vim.opt.showmatch = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.inccommand = "split"
vim.opt.mouse = "v"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.title = true
vim.opt.wildmenu = true
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.updatetime = 300
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.wildignore = "target"
vim.opt.list = false
vim.opt.listchars = {eol = " ", tab = "  ", trail = " "}
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ttyfast = true
vim.opt.spell = true
vim.opt.signcolumn = "yes:1"

local disabled_builtins = {
	"netrwPlugin",
	"tohtml",
	"man",
	"tarPlugin",
	"zipPlugin",
	"gzip"
}

for i = 1, table.maxn(disabled_builtins)
do
	vim.g["loaded_" .. disabled_builtins[i]] = 1
end
