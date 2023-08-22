local M = {
	"nvim-telescope/telescope.nvim", tag = "0.1.2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	}
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
	})
end
	
return M

