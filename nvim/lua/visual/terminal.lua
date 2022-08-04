require("FTerm").setup({
    ft = "Term",
    cmd = os.getenv("SHELL"),
    border = "single",
    auto_close = true,
    hl = "Terminal",
    blend = 5,
    dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.5
    },
    on_exit = nil,
    on_stdout = nil,
    on_stderr = nil,
})
