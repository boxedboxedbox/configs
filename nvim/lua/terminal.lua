require("FTerm").setup({
    ft = 'FTerm',

    cmd = os.getenv('SHELL'),

    border = 'single',

    auto_close = true,

    hl = 'Terminal',

    blend = 7,

    dimensions = {
        height = 0.9, -- Height of the terminal window
        width = 0.9, -- Width of the terminal window
        x = 0.5, -- X axis of the terminal window
        y = 0.5, -- Y axis of the terminal window
    },
    on_exit = nil,

    on_stdout = nil,

    on_stderr = nil,
})
