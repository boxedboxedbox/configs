local cmp = require("cmp")

local kind_icons = {
   Text = "",
   Method = "",
   Function = "",
   Constructor = "",
   Field = "",
   Variable = "",
   Class = "",
   Interface = "",
   Module = "",
   Property = "",
   Unit = "",
   Value = "",
   Enum = "",
   Keyword = "",
   Snippet = "",
   Color = "",
   File = "",
   Reference = "",
   Folder = "",
   EnumMember = "",
   Constant = "",
   Struct = "",
   Event = "",
   Operator = "",
   TypeParameter = "",
}

cmp.setup({
   enabled = function()
      local context = require 'cmp.config.context'
      if vim.api.nvim_get_mode().mode == 'c' then
         return true
      else
         return not context.in_treesitter_capture("comment") 
            and not context.in_syntax_group("Comment")
      end
   end,
	snippet = {
		expand = function(args)
         require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({select = true,}),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
	formatting = {
      format = function(entry, vim_item)
         vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
         
         vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
         })[entry.source.name]
         
         return vim_item
      end
	},
})
