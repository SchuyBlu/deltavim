local M = {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" }
}

function M.config()
	local status, oil = pcall(require, "oil")
	if not status then
		return
	end

	oil.setup({
		default_file_explorer = true,
		columns = { "icon" },
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		view_options = {
			show_hidden = true,
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".")
			end
		},
	})
end

return M

