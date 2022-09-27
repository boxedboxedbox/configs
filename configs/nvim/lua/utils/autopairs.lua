local cmp = require("cmp")
local npairs = require("nvim-autopairs")
-- local Rule = require("nvim-autopairs.rule")
-- local cond = require("nvim-autopairs.conds")
local handlers = require("nvim-autopairs.completion.handlers")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

npairs.setup({
    disable_filetype = {"TelescopePrompt"},
    disable_in_macro = false,
    disable_in_visualblock = false,
    ignored_next_char = [=[[%w%%%"%[%"%.]]=],
    enable_moveright = true,
    enable_afterquote = true,
    enable_check_bracket_line = true,
    enable_bracket_in_quote = true,
    break_undo = true,
    check_ts = false,
    map_cr = true,
    map_bs = true,
    map_c_h = false,
    map_c_w = false,
})


cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
        filetypes = {
            ["*"] = {
                ["("] = {
                    kind = {
                    cmp.lsp.CompletionItemKind.Function,
                    cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"]
            }
        },
        tex = false
    }
}))
