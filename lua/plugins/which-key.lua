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

	-- Function meant to check if dir exists.
	function exists(file)
		local ok, err, code = os.rename(file, file)
		if not ok then
			if code == 13 then
				return true
			end
		end
		return ok, err
	end
	
	local base_mappings = {
		["<F4>"] = { "<cmd>lua _TMUX_TOGGLE()<CR>", "Toggle the terminal" },
		["<F5>"] = { "<cmd>NvimTreeToggle<CR>", "Toggle tree view" }
	}

	local leader_mappings = {
		c = { "<cmd>bdelete<CR>", "Close buffer" }, -- Close whatever buffer you're within
		f = {
			name = "File Explorer",
			f = { "<cmd>Telescope find_files<CR>", "Find files" },
			e = { "<cmd>Oil --float<CR>", "Explore files" },
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
	}

	which_key.register(base_mappings, base_opts)
	which_key.register(leader_mappings, leader_opts)
end

return M

