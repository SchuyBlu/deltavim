local M = {
	"dfendr/trozo.nvim",
	config = true,
	cmd = { "TrozoUploadSelection", "TrozoUploadFile" }
}

function M.config()
	local status, trozo = pcall(require, "trozo")
	if not status then
		return
	end

	trozo.setup({
		browser = true,
		clipboard = true,
	})
end

return M

