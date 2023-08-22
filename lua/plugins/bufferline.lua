local M = {
	"akinsho/bufferline.nvim"
}

function M.config()
	local status, bufferline = pcall(require, "bufferline")
	if not status then
		return
	end

	bufferline.setup({})
end

return M

