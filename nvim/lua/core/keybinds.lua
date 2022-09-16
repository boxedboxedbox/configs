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
-- Split windows (sf)
keymap("n", "sa", ":vs<CR>", opts)
-- Close split windows (sd)
keymap("n", "sd", "<C-w>c", opts)
-- Write changes (ctrl + s)
keymap("n", "<C-s>", "<cmd>w<CR>", opts)
keymap("i", "<C-s>", "<cmd>w<CR>", opts)
-- Move backwards/forwards a word (q/w) 
keymap("n", "q", "b", opts)
-- Jump to the start/end of current line (u/i)
keymap("n", ",", "0", opts)
keymap("n", ".", "$", opts)
-- Undo (ctrl + z)
keymap("n", "<C-z>", "<cmd>u<CR>", opts)
keymap("i", "<C-z>", "<cmd>u<CR>", opts)
-- Resize split windows (alt + left arrow/right arrow)
keymap("i", "<A-Right>", "<cmd>vertical resize -10<CR>", opts)
keymap("i", "<A-Left>", "<cmd>vertical resize +10<CR>", opts)
keymap("n", "<A-Right>", "<cmd>vertical resize -10<CR>", opts)
keymap("n", "<A-Left>", "<cmd>vertical resize +10<CR>", opts)
-- }}

-- Tabline {{{
-- Move to previous/next (alt + ,/.)
keymap("n", "<A-,>", ":BufferPrevious<CR>", opts)
keymap("n", "<A-.>", ":BufferNext<CR>", opts)
-- Re-order to previous/next (alt + </>)
keymap("n", "<A-<>", ":BufferMovePrevious<CR>", opts)
keymap("n", "<A->>", ":BufferMoveNext<CR>", opts)
-- Go to buffer in position (alt + 1..9/0)
keymap("n", "<A-1>", ":BufferGoto 1<CR>", opts)
keymap("n", "<A-2>", ":BufferGoto 2<CR>", opts)
keymap("n", "<A-3>", ":BufferGoto 3<CR>", opts)
keymap("n", "<A-4>", ":BufferGoto 4<CR>", opts)
keymap("n", "<A-5>", ":BufferGoto 5<CR>", opts)
keymap("n", "<A-6>", ":BufferGoto 6<CR>", opts)
keymap("n", "<A-7>", ":BufferGoto 7<CR>", opts)
keymap("n", "<A-8>", ":BufferGoto 8<CR>", opts)
keymap("n", "<A-9>", ":BufferGoto 9<CR>", opts)
keymap("n", "<A-0>", ":BufferLast<CR>", opts)
-- Pin/unpin buffer (alt + p)
keymap("n", "<A-p>", ":BufferPin<CR>", opts)
-- Close buffer (alt + c)
keymap("n", "<A-x>", ":BufferClose<CR>", opts)
-- }}}

-- File Explorer (nvimtree) {{{
keymap("n", "<leader>d", "<cmd>NvimTreeToggle<CR><cmd>setlocal statusline=%#nvimtreeStatusbar#<CR>", opts)
keymap("n", "<leader>s", ":NvimTreeFocus<CR>", opts)
keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)
keymap("n", "<leader>a", ":NvimTreeFindFile<CR>", opts)
-- }}}

-- LSP {{{
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gs", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
keymap("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<CR>", opts)
keymap("n", "g[", ":lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "g]", ":lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "ga", ":lua vim.lsp.buf.code_action()<CR>", opts)
-- }}

-- Fuzzy finder (Telescope) {{{
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
-- }}}

-- Terminal (FTerm) {{{
keymap("n", "<A-t>", "<cmd>lua require('FTerm').toggle()<CR>", opts)
keymap("t", "<A-t>", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<CR>", opts)
-- }}}

-- Hop {{{
keymap("", "f", ":HopWord<CR>", opts)
-- }}}

-- Switch files {{{
keymap("n", "z", ":lua require('navigation.switchfiles').switch_files()<CR>", opts)
-- }}}

-- Compile code (and run it) {{{
keymap("n", "gr", ":lua require('utils.compile').run(nil)<CR>", opts)
keymap("n", "gcr", ":lua require('utils.compile').run('release')<CR>", opts)
keymap("n", "gce", ":lua require('utils.compile').build('release')<CR>", opts)
-- }}}

-- Comment {{{
keymap("n", "ct", "v:lua.Comment.operator() . '_'", { noremap = true, silent = true, expr = true })
keymap("v", "ct", ":<c-u>lua Comment.operator('visual')<CR>", opts)
-- }}}
