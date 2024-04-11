local M = {
	"nvim-telescope/telescope.nvim", tag = "0.1.2",
	dependencies = {
		{
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"BurntSushi/ripgrep",
	}
}

function M.config()
	local status, telescope = pcall(require, "telescope")
	if not status then
		return
	end

	local actions = require("telescope.actions")
	telescope.load_extension("file_browser")

	telescope.setup({
		defaults = {
			layout_config = {
				horizontal = { width = 0.9 },
			},
			path_display = { "smart" },
			file_ignore_patterns = {
				".git/",
				"target/",
				"docs/",
				"vendor/*",
				"%.lock",
				"__pycache__/*",
				"__pycache__/",
				"%.sqlite3",
				"%.ipynb",
				"node_modules/*",
				"%.svg",
				"%.otf",
				"%.ttf",
				"%.webp",
				".dart_tool/",
				".github/",
				".gradle/",
				"gradle/",
				".idea/",
				".settings/",
				".vscode/",
				"build/",
				"env/",
				"node_modules/",
				"%.pdb",
				"%.cache",
				"%.pdf",
				"%.jar",
				"%.docx",
				"%.rar",
				"%.zip",
				"%.7z",
				"%.tar",
				"%.tar.gz",
				"%.epub",
			},

			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,

					["<C-b>"] = actions.results_scrolling_up,
					["<C-f>"] = actions.results_scrolling_down,

					["<CR>"] = actions.select_default,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<Tab>"] = actions.close
				},
			},
		},
		pickers = {
			man_pages = {
				sections = {"ALL"}
			},
		},
	})

	telescope.load_extension("fzf")
end

return M

