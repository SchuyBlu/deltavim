local M = {}

function M.config()
	local status, lspconfig = pcall(require, "lspconfig")
	if not status then
		return
	end
end

return M

