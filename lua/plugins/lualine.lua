local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	}
}

function M.config()
	local status, lualine = pcall(require, "lualine")
	if not status then
		return 
	end

	lualine.setup()
end

return M

