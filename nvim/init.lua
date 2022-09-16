vim.api.nvim_exec([[
    filetype plugin on
    filetype plugin indent on
    syntax on
    set background=dark
    set termguicolors
    colorscheme gruvbox
]], false)

require("core.autocmds")
require("core.completion")
require("core.keybinds")
require("core.lsp")
require("core.options")
require("core.plugins")
require("core.treesitter")

require("navigation.files")
require("navigation.finder")
require("navigation.jump")
require("navigation.switchfiles")

require("utils.autopairs")
require("utils.commenter")
require("utils.compile")

require("visual.colors")
require("visual.dashboard")
require("visual.indentation")
require("visual.statusline")
require("visual.tabline")
require("visual.terminal")
