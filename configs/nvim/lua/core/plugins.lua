-- vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

	use "lukas-reineke/indent-blankline.nvim"
	use "kyazdani42/nvim-web-devicons"
	use "neovim/nvim-lspconfig"
	use "simrat39/rust-tools.nvim"
    use "nvim-treesitter/nvim-treesitter"
	use "kyazdani42/nvim-tree.lua"
	use {
		"hrsh7th/nvim-cmp",
   	    requires = {
      	    "L3MON4D3/LuaSnip",
   		    "saadparwaiz1/cmp_luasnip",
   		    "hrsh7th/cmp-nvim-lsp",
            {"hrsh7th/cmp-buffer", after = "nvim-cmp"},
      	    {"hrsh7th/cmp-path", after = "nvim-cmp"},
		}
	}
    use "romgrk/barbar.nvim"
	use "nvim-lualine/lualine.nvim"
    use {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    }
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    }
    use "goolord/alpha-nvim"
    use "numToStr/FTerm.nvim"
    use "windwp/nvim-autopairs"
    use {
        "phaazon/hop.nvim",
        branch = "v2",
    }
    use "norcalli/nvim-colorizer.lua"
    use "ahmedkhalf/project.nvim"
    use "sbdchd/neoformat"
    use "petertriho/nvim-scrollbar"
end)
