local M = {
	"lukas-reineke/indent-blankline.nvim"
}

function M.config()
	local status, indent = pcall(require, "ibl")
	if not status then
		return
	end

	indent.setup()
end

return M
