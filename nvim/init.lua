vim.api.nvim_exec([[
    filetype plugin on
    filetype plugin indent on
    syntax on
    set background=dark
    set termguicolors
    colorscheme gruvbox
]], false)

require("core.lsp")
require("core.completion")
require("core.treesitter")
require("core.plugins")

require("settings.options")
require("settings.keybinds")

require("navigation.files")
require("navigation.finder")
require("navigation.jump")
require("navigation.switchfiles")

require("visual.statusline")
require("visual.tabline")
require("visual.indentation")
require("visual.dashboard")
require("visual.terminal")
require("visual.colors")

require("utils.commenter")
