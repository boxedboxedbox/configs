filetype plugin on
filetype plugin indent on
syntax on

set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

colorscheme gruvbox

lua require("plugins")

source $HOME/.config/nvim/lua/settings.lua
source $HOME/.config/nvim/lua/commenter.lua
source $HOME/.config/nvim/lua/completion.lua
source $HOME/.config/nvim/lua/indentation.lua
source $HOME/.config/nvim/lua/keybinds.lua
source $HOME/.config/nvim/lua/lsp.lua
source $HOME/.config/nvim/lua/statusline.lua
source $HOME/.config/nvim/lua/tabline.lua
source $HOME/.config/nvim/lua/treesitter.lua
source $HOME/.config/nvim/lua/files.lua
source $HOME/.config/nvim/lua/finder.lua
source $HOME/.config/nvim/lua/dashboard.lua
source $HOME/.config/nvim/lua/terminal.lua
