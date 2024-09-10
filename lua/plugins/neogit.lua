local M = {
	"NeogitOrg/neogit",
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

