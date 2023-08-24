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
	
	local base_mappings = {
		["<F4>"] = { "<cmd>ToggleTerm<CR>", "Toggle the terminal" },
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
			c = { "<cmd>Neogit<CR>", "Stage and commit" },
			s = { "<cmd>Git reset --soft<CR>", "Reset to previous commit without moving index" },
			r = { "<cmd>Git reset --mixed<CR>", "Reset to previous commit and index" },
			h = { "<cmd>Git reset --hard<CR>", "Reset to prevous commit, index, and working directory" },
			-- NOTE: If you don't name your remote target and branch "origin" and "main", reword this cmd
			p = { "<cmd>Git push origin main<CR>", "Push to remote target" },
			u = { "<cmd>Git pull<CR>", "Pull from remote target" },
		}
	}

	which_key.register(base_mappings, base_opts)
	which_key.register(leader_mappings, leader_opts)
end

return M

