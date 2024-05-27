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

	local function non_standard_buffer_open()
		local buffers = vim.api.nvim_list_bufs()

		for _, id in ipairs(buffers) do
			local buftype = vim.bo[id].buftype
			if buftype ~= "" then return true end
		end
		return false
	end

	MYGUIBG=nil
	function toggle_transparency()
		if non_standard_buffer_open() then
			require("notify")("Please close non-standard buffers.")
			return
		end

		if MYGUIBG == nil then
			MYGUIBG = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")
			vim.api.nvim_set_hl(0, "Normal", { bg = nil })
			return
		end
		vim.api.nvim_set_hl(0, "Normal", { bg = MYGUIBG })
		MYGUIBG = nil
	end

	local base_mappings = {
		["<F2>"] = { "<cmd>lua toggle_transparency()<CR>", "Toggles transparent view."},
		["<F4>"] = { "<cmd>lua _TMUX_TOGGLE()<CR>", "Toggle the terminal" },
		["<F5>"] = { "<cmd>NvimTreeToggle<CR>", "Toggle tree view" },
		["<F9>"] = { " <cmd>RunCode<CR>", "Run code" },
		["<F10>"] = {" <cmd>RunProject<CR>", "Run project" },
	}

	local leader_mappings = {
		c = { "<cmd>lua close_focus_buffer()<CR>", "Close buffer" }, -- Close whatever buffer you're within
		C = { "<cmd>lua close_all_buffers_except_current()<CR>", "Close all buffers except current." },
		f = {
			name = "Files",
			f = { "<cmd>Telescope find_files<CR>", "Find files" },
			e = { "<cmd>Oil --float<CR>", "Explore files" },
			p = { "<cmd>Telescope grep_string<CR>", "Find path substring" },
			b = { "<cmd>Telescope file_browser<CR>", "File browser" },
			k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
			m = { "<cmd>Telescope man_pages<CR>", "Man pages" },
			t = { "<cmd>Telescope live_grep<CR>", "Find text" },
			r = { "<cmd>Telescope lsp_references<CR>", "Go to references" },
			d = { "<cmd>Telescope lsp_definitions<CR>", "Go to definitions" },
			i = { "<cmd>Telescope lsp_implementations<CR>", "Go to implementations" },
		},
		t = {
			name = "Tree Explorer",
			t = { "<cmd>NvimTreeToggle<CR>", "Toggle tree view" },
			f = { "<cmd>NvimTreeFindFile<CR>", "Find File in tree" },
			c = { "<cmd>NvimTreeCollapse<CR>", "Collapse tree recursively" },
		},
		p = {
			name = "Tab Pages",
			l = { "<cmd>BufferLineCycleNext<CR>", "Move to the next tab" },
			h = { "<cmd>BufferLineCyclePrev<CR>", "Move the the previous tab" },
		},
		g = {
			name = "Git Commands",
			b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle Git Blame" },
			B = { "<cmd>Telescope git_branches<CR>", "Checkout branches" },
			c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
			l = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Toggle lazygit" },
		},
		s = {
			name = "Show",
			s = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Toggle signature" },
			d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Toggle definition" },
			-- m = { "<cmd>lua _TOP_TOGGLE()<CR>", "Toggle top" },
		},
		i = {
			name = "Icons",
			f = { "<cmd>IconPickerNormal<CR>", "Find icons" },
			y = { "<cmd>IconPickerYank<CR>", "Yank icon" },
		},
	}

	which_key.register(base_mappings, base_opts)
	which_key.register(leader_mappings, leader_opts)
end

return M

