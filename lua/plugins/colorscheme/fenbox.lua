local M = {}

function M.config()
	vim.g.fenbox_background_color = "dark"
	vim.g.fenbox_comment_style = { "italic" }
	vim.g.fenbox_function_style = { "bold" }
	vim.g.fenbox_keyword_style = "NONE"
	vim.g.fenbox_use_original_palette = true

	local colorscheme = "fenbox"
	local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status then
		vim.notify("colorscheme " .. colorscheme .. " not found!")
		return
	end
end

return M
