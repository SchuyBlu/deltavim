local M = {
	"folke/which-key.nvim",
	dependencies = { "echasnovski/mini.icons" },
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

	-- Simple function that spits out a shallow copy of a table, and does not
	-- copy any data deeper than one level.
	local function shallow_copy(in_var)
		local out_var = {}
		if type(in_var) == "table" then
			for in_var_key, in_var_val in pairs(in_var) do
				out_var[in_var_key] = in_var_val
			end
		else
			out_var = in_var
		end
		return out_var
	end

	local base_opts = {
		mode = "n",
		prefix = "",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
		expr = false
	}

	local leader_opts = shallow_copy(base_opts)
	leader_opts.prefix = "<leader>"


	function close_all_buffers_except_current()
		local current_buf = vim.api.nvim_get_current_buf()
		local buffers = vim.api.nvim_list_bufs()

		for _, buf_id in ipairs(buffers) do
			if vim.api.nvim_buf_is_loaded(buf_id)
				and vim.api.nvim_buf_is_valid(buf_id)
				and buf_id ~= current_buf then
				local buftype = vim.bo[buf_id].buftype
				if buftype ~= "terminal" then
					vim.api.nvim_buf_delete(buf_id, { force = false })
				end
			end
		end
	end

	local function list_number_of_normal_buffers()
		local buffers = vim.api.nvim_list_bufs()
		local count = 0

		for _, id in ipairs(buffers) do
			local buftype = vim.bo[id].buftype
			if buftype == "" then count = count + 1 end
		end
		return count
	end

	function close_focus_buffer()
		local res = list_number_of_normal_buffers()

		if res == 0 or res == 1 then
			vim.cmd.wq()
			return
		end

		vim.cmd.bd()
	end

	function M.format_buffer()
		if pcall(require, "conform") then
			-- conform is available, use it for formatting
			vim.cmd("lua require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 500 })")
		else
			-- conform is not available, use LSP formatting
			vim.lsp.buf.format({ async = false })
		end
	end

	vim.api.nvim_create_user_command("FormatBuffer", M.format_buffer, {})

	which_key.add({
		{ "<F4>", "<cmd>lua _TMUX_TOGGLE<CR>", desc = "Toggle the terminal" },
		{ "<F5>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle tree view" },
		{ "<F9>", " <cmd>RunCode<CR>", desc = "Run code" },
		{ "<F10>", " <cmd>RunProject<CR>", desc = "Run project" },

		{ "<leader>c", "<cmd>lua close_focus_buffer()<CR>", desc = "Close buffer" },
		{ "<leader>C", "<cmd>lua close_all_buffers_except_current()<CR>", desc = "Close all buffers except current." },

		{ "<leader>f", group = "Files", nowait = true, remap = false },
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fe", "<cmd>Oil --float<CR>", desc = "Explore files" },
		{ "<leader>fp", "<cmd>Telescope grep_string<CR>", desc = "Find path substring" },
		{ "<leader>fb", "<cmd>Telescope file_browser<CR>", desc = "File browser" },
		{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
		{ "<leader>fm", "<cmd>Telescope man_pages<CR>", desc = "Man pages" },
		{ "<leader>ft", "<cmd>Telescope live_grep<CR>", desc = "Find text" },
		{ "<leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "Go to references" },
		{ "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", desc = "Go to definitions" },
		{ "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", desc = "Go to implementations" },

		{ "<leader>t", group = "Tree Explorer", nowait = true, remap = false },
		{ "<leader>tt", "<cmd>NvimTreeToggle<CR>", desc = "Toggle tree view" },
		{ "<leader>tf", "<cmd>NvimTreeFindFile<CR>", desc = "Find File in tree" },
		{ "<leader>tc", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse tree recursively" },

		{ "<leader>p", group = "Tab Pages", nowait = true, remap = false },
		{ "<leader>pl", "<cmd>BufferLineCycleNext<CR>", desc = "Move to the next tab" },
		{ "<leader>ph", "<cmd>BufferLineCyclePrev<CR>", desc = "Move the the previous tab" },

		{ "<leader>g", group = "Git Commands", nowait = true, remap = false },
		{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Git Blame" },
		{ "<leader>gB", "<cmd>Telescope git_branches<CR>", desc = "Checkout branches" },
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
		{ "<leader>gl", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Toggle lazygit" },

		{ "<leader>s", group = "Show", nowait = true, remap = false },
		{ "<leader>ss", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Toggle signature" },
		{ "<leader>sd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Toggle definition" },

		{ "<leader>i", group = "Icons", nowait = true, remap = false },
		{ "<leader>if", "<cmd>IconPickerNormal<CR>", desc = "Find icons" },
		{ "<leader>iy", "<cmd>IconPickerYank<CR>", desc = "Yank icon" },

		{ "<leader>l", group = "Language", nowait = true, remap = false },
		{ "<leader>lf", "<cmd>FormatBuffer<cr>", desc = "Format file."}


	})
end

return M
