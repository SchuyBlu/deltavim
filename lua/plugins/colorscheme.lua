return {
	{ "folke/tokyonight.nvim" },
	{ "morhetz/gruvbox" },
	--{ "lunarvim/darkplus.nvim" },
	{ "tanvirtin/monokai.nvim" },
	{ "kaiuri/nvim-juliana" },
	{ "sainnhe/everforest" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "NLKNguyen/papercolor-theme" },
	{ "tckmn/hotdog.vim" },
	{ "kylelaker/riscv.vim" },
	{ "mellow-theme/mellow.nvim" },
	{ "Yazeed1s/oh-lucy.nvim" },
	{ "AhmedAbdulrahman/aylin.vim" },
	{ "sts10/vim-pink-moon" },
	{
		"dfendr/fenbox",
		lazy = false,
		config = function()
			require("plugins.colorscheme.fenbox").config()
		end,
	},
	{ "projekt0n/github-nvim-theme" },
	{
		"SchuyBlu/cat-chromatic.nvim",
		dir = "~/workspace/cat-chromatic.nvim/",
		lazy = false,
		priority = 1000,
	},
}

