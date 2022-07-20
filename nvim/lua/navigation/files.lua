require("project_nvim").setup({
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git",  "Makefile", "Cargo.toml", "src" },
    ignore_lsp = {},
    exclude_dirs = { "~/.cargo/*" },
    show_hidden = true,
    silent_chdir = true,
    datapath = vim.fn.stdpath("data"),
})

require("nvim-tree").setup {
    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = false,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    sort_by = "name",
    update_cwd = true,
    reload_on_bufenter = false,
    respect_buf_cwd = true,
    view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 25,
        height = 25,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
            custom_only = true,
            list = {
                -- custom mappings go here
            },
        },
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
        enable = false,
        icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
        },
    },
    icons = {
        webdev_colors = true,
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
        },
        glyphs = {
            default = "",
            symlink = "",
            folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
            },
            git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
            },
        },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    ignore_ft_on_setup = {},
    system_open = {
        cmd = "",
        args = {},
    },
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
    },
    filesystem_watchers = {
        enable = false,
        interval = 100,
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 400,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
    },
    expand_all = {
        max_folder_discovery = 300,
    },
    open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
                },
            },
        },
        remove_file = {
        close_window = true,
        },
    },
    trash = {
        cmd = "rm",
        require_confirm = true,
    },
    live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
    },
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },
}