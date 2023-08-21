local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end
}

function M.config()
	local status, which_key = pcall(require, "which-key")
	if not status then
		return
	end
	
	local opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
		expr = false,
	}

	local mappings = {
		f = {
			name = "Telescope",
			f = { "<cmd>Telescope find_files<CR>", "Find files" },
		},
	}

	which_key.register(mappings, opts)

end

return M
