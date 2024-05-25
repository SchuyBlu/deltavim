local M = {
	"NeogitOrg/neogit",
	version = "v0.0.1",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"sindrets/diffview.nvim"
	},
	config = true
}

function M.config()
	local status, neogit = pcall(require, "neogit")
	if not status then
		return
	end
	neogit.setup({})
end

return M

