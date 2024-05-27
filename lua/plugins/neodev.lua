local M = {
	"folke/neodev.nvim",
	opts = {},
	priority = 1000,
}

function M.config()
	local status, neodev = pcall(require, "neodev")
	if not status then
		return
	end

	neodev.setup()
end

return M

