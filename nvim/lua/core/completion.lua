local cmp = require("cmp")

local kind_icons = {
   Text = "",
   Method = "",
   Function = "",
   Constructor = "",
   Field = "",
   Variable = "",
   Class = "",
   Interface = "",
   Module = "",
   Property = "",
   Unit = "",
   Value = "",
   Enum = "",
   Keyword = "",
   Snippet = "",
   Color = "",
   File = "",
   Reference = "",
   Folder = "",
   EnumMember = "",
   Constant = "",
   Struct = "",
   Event = "",
   Operator = "",
   TypeParameter = "",
}

cmp.setup({
    enabled = function()
        local context = require "cmp.config.context"
        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture("comment") 
                and not context.in_syntax_group("Comment")
        end
    end,
	snippet = {
		expand = function(args)
            require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({select = true}),
	},
	sources = {
		{name = "nvim_lsp"},
		{name = "luasnip"},
		{name = "path"},
		{name = "buffer"},
	},
	formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
         
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
         
            return vim_item
        end
	},
})

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
local handlers = require("nvim-autopairs.completion.handlers")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

npairs.setup({
    disable_filetype = {"TelescopePrompt"},
    disable_in_macro = false,  -- disable when recording or executing a macro
    disable_in_visualblock = false, -- disable when insert after visual block mode
    ignored_next_char = [=[[%w%%%"%[%"%.]]=],
    enable_moveright = true,
    enable_afterquote = true,  -- add bracket pairs after quote
    enable_check_bracket_line = true,
    enable_bracket_in_quote = true, --
    break_undo = true, -- switch for basic rule break undo sequence
    check_ts = false,
    map_cr = true,
    map_bs = true,  -- map the <BS> key
    map_c_h = false,  -- Map the <C-h> key to delete a pair
    map_c_w = false, -- map <c-w> to delete a pair if possible
})

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
        filetypes = {
            ["*"] = {
                ["("] = {
                    kind = {
                    cmp.lsp.CompletionItemKind.Function,
                    cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"]
            }
        },
        tex = false
    }
}))

-- I found a perfect regex string,
-- but either Lua or autopairs doesn't want to work with it.
-- Regex pattern: %w \( %s*? | .*? |
-- Time wasted = 3 to 4 hours, I don't even know anymore.
-- Also, that "use_regex" is a bit misleading, because it's actually Lua pattern that it's executing.
npairs.add_rule(Rule("%w%(|.*|", " {}", "rust")
    :use_regex(true, "|")
)

npairs.add_rule(Rule("<", ">", "rust"))

npairs.add_rule(Rule(" ", " ")
    :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({"()", "[]", "{}"}, pair)
	end)
)

require("luasnip.loaders.from_vscode").lazy_load()
