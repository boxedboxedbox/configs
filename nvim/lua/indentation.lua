vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineChar guifg=#505617 gui=nocombine]]
vim.opt.list = true

vim.g.indent_blankline_space_char_highlight_list = {"Error", "Function"}
vim.g.indent_blankline_char = "|"

require("indent_blankline").setup {
    space_char_blankline = " ",
	show_current_context = false,
    show_current_context_start = true,

    char_highlight_list = {
        "IndentBlanklineChar",
    },
}
