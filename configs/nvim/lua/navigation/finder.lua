local telescope = require("telescope")

telescope.setup({
    defaults = {
        layout_config = {
            width = 0.9,
            prompt_position = "top",
            preview_cutoff = 120,
        },
        winblend = 15,
        border = {},
        borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        width = 1;
        height = 1;
        show_line = true;
        prompt_prefix = "❯ ";
        prompt_title = false;
        results_title = false;
        preview_title = false;
        mappings = {
            i = {
                ["<C-h>"] = "which_key"
            }
        },
    },
    pickers = {},
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})

telescope.load_extension("projects")
telescope.load_extension("fzf")
