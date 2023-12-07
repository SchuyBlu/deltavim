return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("plugins.lsp.mason").config()
		end
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp.lspconfig").config()
		end
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.lsp.signature").config()
		end
	},
}

