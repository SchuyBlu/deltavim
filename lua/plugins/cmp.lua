local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	}
}

function M.config()
	local status, cmp = pcall(require, "cmp")
	if not status then
		return
	end

	cmp.setup({
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-c>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),

		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					buffer = "[Buffer]",
				})[entry.source.name]
				return vim_item
			end,
		},

		sources = {
			{ name = "nvim_lsp" },
			{ name = "buffer" },
		},

		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},

		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},

		experimental = {
			ghost_texture = true,
		},
	})
end

return M

