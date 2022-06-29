-- this is a mess, but don't care

vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.clipboard = "unnamedplus"
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
vim.opt.wildignore = "target/*,"
vim.opt.list = false
vim.opt.listchars = {eol = " ", tab = "  ", trail = " "}
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ttyfast = true
vim.opt.spell = true

vim.api.nvim_exec([[let g:python_highlight_space_errors = 0]], false)

vim.api.nvim_exec([[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)]], false)
vim.api.nvim_exec([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]], false)

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

nvim_tree_events.on_tree_open(function ()
   bufferline_state.set_offset(31, "File Tree")
end)

nvim_tree_events.on_tree_close(function ()
   bufferline_state.set_offset(0)
end)

