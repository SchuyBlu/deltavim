local M = {
	"nvim-telescope/telescope.nvim", tag = "0.1.2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim"
	},
}

function M.config()
	local status, telescope = pcall(require, "telescope")
	if not status then
		return
	end

	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			path_display = { "smart" },
		},

		extension = {
			theme = "ivy",
			hijack_netrw = true
		}
	})

	telescope.load_extension("file_browser")
end
	
return M

