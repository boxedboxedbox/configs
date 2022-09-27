-- MIT License
--
-- Copyright (c) 2021 Evgeni Chasnovski
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- Module definition ==========================================================
local Comment = {}
local H = {}

Comment.config = {
    prehook = function() end,
    posthook = function() end,
}

_G.Comment = Comment

-- Module functionality =======================================================
--- Main function to be mapped
---
--- It is meant to be used in expression mappings (see |map-<expr>|) to enable
--- dot-repeatability and commenting on range. There is no need to do this
--- manually, everything is done inside |Comment.setup()|.
---
--- It has a somewhat unintuitive logic (because of how expression mapping with
--- dot-repeatability works): it should be called without arguments inside
--- expression mapping and with argument when action should be performed.
---
---@param mode string Optional string with "operatorfunc" mode (see |g@|).
---
---@return string "g@" if called without argument, "" otherwise (but after
---   performing action).
Comment.operator = function(mode)
    -- If used without arguments inside expression mapping:
    -- - Set itself as `operatorfunc` to be called later to perform action.
    -- - Return "g@" which will then be executed resulting into waiting for a
    --   motion or text object. This textobject will then be recorded using `"[`
    --   and `"]` marks. After that, `operatorfunc` is called with `mode` equal
    --   to one of "line", "char", or "block".
    -- NOTE: setting `operatorfunc` inside this function enables usage of "count"
    -- like `10gc_` toggles comments of 10 lines below (starting with current).
    if mode == nil then
        vim.cmd("set operatorfunc=v:lua.Comment.operator")
        return "g@"
    end

    -- If called with non-nil `mode`, get target region
    -- and perform comment toggling over it.
    local mark_left, mark_right = "[", "]"
    if mode == "visual" then
        mark_left, mark_right = "<", ">"
    end

    local line_left, col_left = unpack(vim.api.nvim_buf_get_mark(0, mark_left))
    local line_right, col_right = unpack(vim.api.nvim_buf_get_mark(0, mark_right))

    -- Do nothing if "left" mark is not on the left (earlier in text) of "right"
    -- mark (indicating that there is nothing to do, like in comment textobject).
    if (line_left > line_right)
        or (line_left == line_right
        and col_left > col_right)
    then
        return
    end

    -- Using `vim.cmd()` wrapper to allow usage of `lockmarks` command, because
    -- raw execution will delete marks inside region
    -- (due to `vim.api.nvim_buf_set_lines()`).
    vim.cmd(string.format("lockmarks lua Comment.toggle_lines(%d, %d)", line_left, line_right))

    return ""
end

--- Toggle comments between two line numbers
---
--- It uncomments if lines are comment (every line is a comment) and comments
--- otherwise. It respects indentation and doesn't insert trailing
--- whitespace. Toggle commenting not in visual mode is also dot-repeatable
--- and respects |count|.
---
--- Before successful commenting it executes `config.hooks.pre`.
--- After successful commenting it executes `config.hooks.post`.
---
--- # Notes~
---
--- 1. Currently call to this function will remove marks inside written range.
---    Use |lockmarks| to preserve marks.
---
---@param line_start number Start line number (inclusive from 1 to number of lines).
---@param line_end number End line number (inclusive from 1 to number of lines).
Comment.toggle_lines = function(line_start, line_end)
    local n_lines = vim.api.nvim_buf_line_count(0)

    if not (1 <= line_start and line_start <= n_lines
        and 1 <= line_end and line_end <= n_lines)
    then
        error(("(comment) `line_start` and `line_end` should be within range [1; %s].")
        :format(n_lines))
    end

    if not (line_start <= line_end)
    then
        error("(comment) `line_start` should be less than or equal to `line_end`.")
    end

    local config = Comment.config
    Comment.config.prehook()

    local comment_parts = H.make_comment_parts()
    local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
    local indent, is_comment = H.get_lines_info(lines, comment_parts)

    local f
    if is_comment then
        f = H.make_uncomment_function(comment_parts)
    else
        f = H.make_comment_function(comment_parts, indent)
    end

    for n, l in pairs(lines) do
        lines[n] = f(l)
    end

    -- NOTE: This function call removes marks inside written range. To write
    -- lines in a way that saves marks, use one of:
    -- - `lockmarks` command when doing mapping (current approach).
    -- - `vim.fn.setline(line_start, lines)`, but this is **considerably**
    --   slower: on 10000 lines 280ms compared to 40ms currently.
    vim.api.nvim_buf_set_lines(0, line_start - 1, line_end, false, lines)

    Comment.config.posthook()
end

-- Core implementations -------------------------------------------------------
H.make_comment_parts = function()
    local cs = vim.api.nvim_buf_get_option(0, "commentstring")

    if cs == ""
    then
        H.message([[(comment) Option "commentstring" is empty.]])
        return { left = "", right = "" }
    end

    -- Assumed structure of "commentstring":
    -- <space> <left> <space> <"%s"> <space> <right> <space>
    -- So this extracts parts without surrounding whitespace
    local left, right = cs:match("^%s*(.-)%s*%%s%s*(.-)%s*$")
    return { left = left, right = right }
end

H.make_comment_check = function(comment_parts)
    local l, r = comment_parts.left, comment_parts.right
    -- String is commented if it has structure:
    -- <space> <left> <anything> <right> <space>
    local regex = string.format("^%%s-%s.*%s%%s-$", vim.pesc(l), vim.pesc(r))

    return function(line) return line:find(regex) ~= nil end
end

H.get_lines_info = function(lines, comment_parts)
    local n_indent, n_indent_cur = math.huge, math.huge
    local indent, indent_cur

    local is_comment = true
    local comment_check = H.make_comment_check(comment_parts)

    for _, l in pairs(lines)
    do
        -- Update lines indent: minimum of all indents except empty lines
        if n_indent > 0
        then
            _, n_indent_cur, indent_cur = l:find("^(%s*)")
            -- Condition "current n-indent equals line length" detects empty line
            if (n_indent_cur < n_indent)
                and (n_indent_cur < l:len())
            then
                -- NOTE: Copy of actual indent instead of recreating it with `n_indent`
                -- allows to handle both tabs and spaces
                n_indent = n_indent_cur
                indent = indent_cur
            end
        end
        -- Update comment info: lines are comment if every single line is comment
        if is_comment then is_comment = comment_check(l) end
    end

    -- `indent` can still be `nil` in case all `lines` are empty
    return indent or "", is_comment
end

H.make_comment_function = function(comment_parts, indent)
  -- NOTE: this assumes that indent doesn't mix tabs with spaces
    local nonindent_start = indent:len() + 1

    local l, r = comment_parts.left, comment_parts.right
    local lpad = (l == "") and "" or " "
    local rpad = (r == "") and "" or " "

    local empty_comment = indent .. l .. r
  -- Escape literal "%" symbols in comment parts (like in LaTeX) to be "%%"
  -- because they have special meaning in `string.format` input. NOTE: don't
  -- use `vim.pesc()` here because it also escapes other special characters
  -- (like "-", "*", etc.).
    local nonempty_format = indent .. l:gsub("%%", "%%%%") .. lpad .. "%s" .. rpad .. r:gsub("%%", "%%%%")

    return function(line)
    -- Line is empty if it doesn't have anything except whitespace
        if line:find("^%s*$") ~= nil
        then
            -- If doesn't want to comment empty lines, return `line` here
            return empty_comment
        else
            return string.format(nonempty_format, line:sub(nonindent_start))
        end
    end
end

H.make_uncomment_function = function(comment_parts)
    local l, r = comment_parts.left, comment_parts.right
    local lpad = (l == "") and "" or "[ ]?"
    local rpad = (r == "") and "" or "[ ]?"

    -- Usage of `lpad` and `rpad` as possbile single space enables uncommenting
    -- of commented empty lines without trailing whitespace (like "  #").
    local uncomment_regex = string.format("^(%%s*)%s%s(.-)%s%s%%s-$", vim.pesc(l), lpad, rpad, vim.pesc(r))

    return function(line)
        local indent, new_line = string.match(line, uncomment_regex)

        -- Return original if line is not commented
        if new_line == nil then return line end

        -- Remove indent if line is a commented empty line
        if new_line == "" then indent = "" end

        return ("%s%s"):format(indent, new_line)
    end
end

H.map = function(mode, key, rhs, opts)
    if key == "" then return end

    opts = vim.tbl_deep_extend("force", { noremap = true, silent = true }, opts or {})

    vim.api.nvim_set_keymap(mode, key, rhs, opts)
end

H.message = function(msg) vim.cmd("echomsg " .. vim.inspect("(comment) " .. msg)) end
