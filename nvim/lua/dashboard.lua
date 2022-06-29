-- This file is a horrible mess. (And I didn't write this)

if (vim.api.nvim_exec('echo argc()', true) == "0")
then
   local function split(s)
   local t = {}
   local max_line_length = vim.api.nvim_get_option('columns')
   local longest = 0
   for far in s:gmatch("[^\r\n]+") do
      local line
      far:gsub('(%s*)(%S+)',
      function(spc, word)
         if not line or #line + #spc + #word > max_line_length then
            table.insert(t, line)
            line = word
         else
            line = line..spc..word
            longest = max_line_length
         end
      end)

      if (#line > longest) then
        longest = #line
      end
      table.insert(t, line)
   end
   -- Center all strings by the longest
   for i = 1, #t do
      local space = longest - #t[i]
      local left = math.floor(space/2)
      local right = space - left
      t[i] = string.rep(' ', left) .. t[i] .. string.rep(' ', right)
   end
   return t
end

  -- Function to retrieve console output.
local function capture(cmd)
   local handle = assert(io.popen(cmd, 'r'))
   local output = assert(handle:read('*a'))
   handle:close()
   return output
end

local function button(sc, txt, keybind, keybind_opts)
   local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

   local opts = {
      position = "center",
      shortcut = sc,
      cursor = 5,
      width = 50,
      align_shortcut = "right",
      hl_shortcut = "Conditional",
   }
   if keybind then
      keybind_opts = vim.F.if_nil(keybind_opts, {noremap = true, silent = true, nowait = true})
      opts.keymap = {"n", sc_, keybind, keybind_opts}
   end

   local function on_press()
      local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
   end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
    end

    Headers = {
      {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
      },
      {
      "                                   ",
      "                                   ",
      "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
      "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
      "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
      "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
      "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
      "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
      "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
      " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
      " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
      "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
      "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
      "                                   ",
      },
    }

    local header = {
        type = "text",
        val = Headers[2], -- lua be like: arrays start at 1.
        opts = {
            position = "center",
            hl = "Type"
            -- wrap = "overflow";
        }
    }

    local footer = {
        type = "text",
        val = split(capture('rdn')),
        hl = "NvimTreeRootFolder",
        opts = {
            position = "center",
            hl = "Conditional",
        }
    }

  local buttons = {
      type = "group",
      val = {
         button("e", "  New Buffer",            ':tabnew<CR>'),
         button("f", "  Find file",             ':Telescope find_files<CR>'),
         button("h", "  Recently opened files", ':Telescope oldfiles<CR>'),
         button("r", "  Recent projects",       ':Telescope projects<CR>'),
         button("m", "  Word Finder",           ':Telescope live_grep<CR>'),
      },
      opts = {
         spacing = 1
      }
   }

   local ol = { -- occupied lines
      icon = #header.val,            -- CONST: number of lines that your header will occupy
      message = 1 + #footer.val,             -- CONST: because of padding at the bottom
      length_buttons = #buttons.val * 2 - 1, -- CONST: it calculate the number that buttons will occupy
      neovim_lines = 3,                      -- CONST: 2 of command line, 1 of the top bar
      padding_between = 2,                   -- STATIC: can be set to anything, padding between keybinds and header
   }

   local left_terminal_value = vim.api.nvim_get_option('lines') - (ol.length_buttons + ol.message + ol.padding_between + ol.icon + ol.neovim_lines)
   local top_padding = math.floor(left_terminal_value / 2)
   local bottom_padding = left_terminal_value - top_padding

   local opts = {
      layout = {
         { type = "padding", val = top_padding },
         header,
         { type = "padding", val = ol.padding_between },
         buttons,
         footer,
         { type = "padding", val = bottom_padding },
      },
      opts = {
         margin = 5
      },
   }

   require('alpha').setup(opts)
end
