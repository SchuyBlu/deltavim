local cmdline = true
local M = {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdLineEnter" },
	dependencies = {
		"onsails/lspkind.nvim",
		"windwp/nvim-autopairs",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{ "hrsh7th/cmp-cmdline", enabled = cmdline },
		{ "dmitmel/cmp-cmdline-history", enabled = cmdline },
		"hrsh7th/cmp-path",
	},
	enabled = true,
}

function M.config()
	vim.o.completeopt = "menu,menuone,noselect"

	require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local status, cmp = pcall(require, "cmp")
	if not status then
		return
	end

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

	local luasnip = require("luasnip")
	luasnip.config.setup({
		history = true,
		region_check_events = "InsertEnter",
		delete_check_events = "TextChanged,InsertLeave",
	})

	local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end
		},
		mapping = cmp.mapping.preset.insert({
			["<C-g>"] = function()
				if cmp.visible_docs() then
					cmp.close_docs()
				else
					cmp.open_docs()
				end
			end,
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
			["<Tab>"] = cmp.mapping(function(fallback)
				if luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				--elseif cmp.visible() then
				--	cmp.select_next_item()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end,
			 {
			 	"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				--elseif cmp.visible() then
				--	cmp.select_prev_item()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end,
			 {
			 	"i",
				"s",
			}),
		}),

		formatting = {
			expandable_indicator = true,
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					buffer = "[Buffer]",
				})[entry.source.name]
				return vim_item
			end,
		},

		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" }
		}),

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

