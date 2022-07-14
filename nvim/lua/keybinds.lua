local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Leader key {{{
keymap("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- }}}

-- Custom {{{
-- Move line up/down (alt + a/s)
keymap("i", "<A-a>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-s>", "<Esc>:m .-2<CR>==gi", opts)
-- Move visually selected up/down (alt + a/s)
keymap("v", "<A-a>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-s>", ":m '<-2<CR>gv=gv", opts)
-- Copies filepath to clipboard (yf)
keymap("n", "yf", ":let @+=expand('%:p')<CR>", opts)
-- Copies current directory to clipboard (yd)
keymap("n", "yd", ":let @+=expand('%:p:h')<CR>", opts)
-- Move between panes to left/bottom/top/right
keymap("n", "<C-Left>", "<C-w>h", opts)
keymap("n", "<C-Down>", "<C-w>j", opts)
keymap("n", "<C-Up>", "<C-w>k", opts)
keymap("n", "<C-Right>", "<C-w>l", opts)
-- }}

-- Tabline {{{
-- Move to previous/next (alt + ,/.)
keymap('n', '<A-,>', ':BufferPrevious<CR>', opts)
keymap('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next (alt + </>)
keymap('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
keymap('n', '<A->>', ':BufferMoveNext<CR>', opts)
-- Goto buffer in position (alt + 1..9/0)
keymap('n', '<A-1>', ':BufferGoto 1<CR>', opts)
keymap('n', '<A-2>', ':BufferGoto 2<CR>', opts)
keymap('n', '<A-3>', ':BufferGoto 3<CR>', opts)
keymap('n', '<A-4>', ':BufferGoto 4<CR>', opts)
keymap('n', '<A-5>', ':BufferGoto 5<CR>', opts)
keymap('n', '<A-6>', ':BufferGoto 6<CR>', opts)
keymap('n', '<A-7>', ':BufferGoto 7<CR>', opts)
keymap('n', '<A-8>', ':BufferGoto 8<CR>', opts)
keymap('n', '<A-9>', ':BufferGoto 9<CR>', opts)
keymap('n', '<A-0>', ':BufferLast<CR>', opts)
-- Pin/unpin buffer (alt + p)
keymap('n', '<A-p>', ':BufferPin<CR>', opts)
-- Close buffer (alt + c)
keymap('n', '<A-x>', ':BufferClose<CR>', opts)
-- }}}

-- File Explorer (nvimtree) {{{
keymap("n", "<leader>d", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>s", ":NvimTreeFocus<CR>", opts)
keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)
keymap("n", "<leader>a", ":NvimTreeFindFile<CR>", opts)
-- }}}

-- Rust LSP {{{
keymap("n", "<C-]>", ":lua vim.lsp.buf.definiton()<CR>", opts)
keymap("n", "K", ":lua require'rust-tools.hover_actions'.hover_actions()<CR>", opts)
keymap("n", "gs>", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "1gd>", ":lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "gr>", ":lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "g0>", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
keymap("n", "gw>", ":lua vim.lsp.buf.workspace_symbol()<CR>", opts)
keymap("n", "gd>", ":lua vim.lsp.buf.definiton()<CR>", opts)
keymap("n", "ga", ":lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "g[", ":lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "g]", ":lua vim.diagnostic.goto_next()<CR>", opts)
-- }}

-- Fuzzy finder (Telescope) {{{
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
-- }}}

-- Terminal (FTerm) {{{
vim.keymap.set('n', '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
-- }}}
