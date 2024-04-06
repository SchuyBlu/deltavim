return {

	-- LSP package manager
	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.lsp.mason")
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("plugins.lsp.mason_tool_installer")
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
	},

	{
		"mfussenegger/nvim-dap",
	},

	{
		"neovim/nvim-lspconfig",
	},

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{
		"onsails/lspkind.nvim",
	},

	{
		"mfussenegger/nvim-jdtls",
	},
}
