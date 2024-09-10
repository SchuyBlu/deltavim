local M = {
	"mistricky/codesnap.nvim",
	build = "make"
}

function M.config()
	local status, codesnap = pcall(require, "codesnap")
	if not status then
		return
	end

	codesnap.setup({
		watermark = "",
		mac_window_bar = false
	})
end

return M
