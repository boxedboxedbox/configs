local colors = {
    bg0          = "#3b3634",
    bg1          = "#201f1e",
    bg2          = "#292e28",
    white        = "#ebdbb2",
    black        = "#1d1d1d",
    green        = "#35ad68",
    blue         = "#009975",
    orange       = "#fe8019",
    yellow       = "#b8bb26",
    red          = "#fb4934",
    purple       = "#713184",
    gray         = "#3c3836",
    gray1        = "#707070",
}

local custom_theme = {
    normal = {
        a = {bg = colors.green, fg = colors.black, gui = "bold"},
        b = {bg = colors.bg0, fg = colors.white},
        c = {bg = colors.black, fg = colors.white}
    },
    insert = {
        a = {bg = colors.blue, fg = colors.black, gui = "bold"},
        b = {bg = colors.bg0, fg = colors.white},
        c = {bg = colors.bg1, fg = colors.white}
    },
    visual = {
        a = {bg = colors.orange, fg = colors.black, gui = "bold"},
        b = {bg = colors.bg0, fg = colors.white},
        c = {bg = colors.bg1, fg = colors.white}
    },
    replace = {
        a = {bg = colors.red, fg = colors.black, gui = "bold"},
        b = {bg = colors.bg0, fg = colors.white},
        c = {bg = colors.bg1, fg = colors.white}
    },
    command = {
        a = {bg = colors.yellow, fg = colors.black, gui = "bold"},
        b = {bg = colors.bg0, fg = colors.white},
        c = {bg = colors.bg1, fg = colors.white}
    },
    inactive = {
        a = {bg = colors.purple, fg = colors.black, gui = "bold"},
        b = {bg = colors.bg2, fg = colors.gray1},
        c = {bg = colors.bg1, fg = colors.gray}
    }
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = custom_theme,
		component_separators = { left = "", right = ""},
		section_separators = { left = "", right = ""},
		disabled_filetypes = {"packer", "NvimTree"},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = {"mode"},
		lualine_b = {"filename"},
		lualine_c = {"branch", "diagnostics"},
		lualine_x = {"filetype"},
		lualine_y = {"progress"},
		lualine_z = {"location"}
	},
	inactive_sections = {
		lualine_a = {"mode"},
		lualine_b = {"filename"},
		lualine_c = {"branch", "diagnostics"},
	    lualine_x = {"filetype"},
		lualine_y = {"progress"},
		lualine_z = {"location"}
	},
	tabline = {},
	extensions = {}
})
