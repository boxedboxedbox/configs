-- this doesn't seem to work.
require("project_nvim").setup {
    manual_mode = false,

    detection_methods = { "lsp", "pattern" },

    patterns = {
        ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json",
        "Cargo.toml", "Cargo.lock", "build.rs",
    },

    ignore_lsp = {},

    exclude_dirs = { "~/.cargo/*" },

    show_hidden = true,

    silent_chdir = true,

    datapath = "~/.config/nvim/data/",
}
