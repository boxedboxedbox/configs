vim.api.nvim_exec([[let g:python_highlight_space_errors = 0]], false)

vim.api.nvim_exec([[au BufWritePre *.rs lua vim.lsp.buf.format(nil, 200)]], false)
vim.api.nvim_exec([[au CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]], false)
vim.api.nvim_exec([[au BufWritePost *.c,*.cpp,*.h,*.hpp silent exec "!$HOME/scripts/clang-format-all src/"]], false)

vim.api.nvim_exec([[au BufRead,BufNewFile *.jpg,*.png,*.gif,*.jpeg set filetype=image]], false)
vim.api.nvim_exec([[au BufRead,BufNewFile *.mp3,*.flac,*.wav,*.ogg set filetype=audio]], false)
vim.api.nvim_exec([[au BufRead,BufNewFile *.avi,*.mp4,*.mkv,*.mov,*.mpg set filetype=video]], false)

vim.api.nvim_exec([[au FileType * ":ColorizerAttachToBuffer<CR>" ]], false)

local nvim_tree_events = require("nvim-tree.events")
local bufferline_state = require("bufferline.state")

nvim_tree_events.on_tree_open(function()
   bufferline_state.set_offset(25, "File Tree")
end)

nvim_tree_events.on_tree_close(function()
   bufferline_state.set_offset(0)
end)
