local M = {
	"akinsho/toggleterm.nvim"
}

function M.config()
	local status, tterm = pcall(require, "toggleterm")
	if not status then
		return
	end

	tterm.setup({
		direction = "float",
		shade_terminals = true
	})
end

return M

