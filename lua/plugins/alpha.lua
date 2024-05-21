local M = {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	local status, alpha = pcall(require, "alpha")
	if not status then
		return
	end
	
	local function button(sc, text, keybind, keybind_opts)
		local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
		
		local opts = {
			position = "center",
			shortcut = sc,
			cursor = 3,
			width = 50,
			align_shortcut = "right",
			hl_shortcut = "Keyword",
		}

		if keybind then
			keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
			opts.keymap = { "n", sc_, keybind, keybind_opts }
		end

		local function on_press()
			local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
			vim.api.nvim_feedkeys(key, "t", false)
		end

		return {
			type = "button",
			val = text,
			on_press = on_press,
			opts = opts,
		}
	end

	-- Taken from Dylan's config: https://github.com/dfendr/nvim/blob/ad15d1e33ba40693fbac344d23128664bb7f6bda/lua/core/functions.lua
	local function open_todo()
		local home_dir = os.getenv("HOME")
		local todo_path = home_dir .. "/todo.md"

		-- Create file if doesn't exist
		if vim.loop.fs_stat(todo_path) == nil then
			vim.loop.fs_open(todo_path, "w", 438)
		end

		-- open file in Neovim
		vim.cmd("edit " .. todo_path)
	end

	local header_padding = {
		type = "padding",
		val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.1) })
	}

	local header_ascii_art = {
		type = "text",
		val = {
			[[┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓]],
			[[┃ ██████╗ ███████╗██╗  ████████╗ █████╗ ██╗   ██╗██╗███╗   ███╗ ┃]],
			[[┃ ██╔══██╗██╔════╝██║  ╚══██╔══╝██╔══██╗██║   ██║██║████╗ ████║ ┃]],
			[[┃ ██║  ██║█████╗  ██║     ██║   ███████║██║   ██║██║██╔████╔██║ ┃]],
			[[┃ ██║  ██║██╔══╝  ██║     ██║   ██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║ ┃]],
			[[┃ ██████╔╝███████╗███████╗██║   ██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║ ┃]],
			[[┃ ╚═════╝ ╚══════╝╚══════╝╚═╝   ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ┃]],
			[[┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛]],
		},
		opts = {
			position = "center",
			hl = "Type",
		},
	}

	local sig = {
		type = "text",
		val = {
			[[|_        _  _ |_         ]],
			[[|_) \/   _> (_ | | |_| \/ ]],
			[[	 /                  /  ]],
		},

		opts = {
			position = "center",
			hl = "Type",
		},
	}

	local buttons = {
		type = "group",
		val = {
			button("n", "󰎔  New File", "<cmd>ene<CR>"),
			button("l", "  Open Todo List", open_todo),
			button("f", "󰈞  Find Files", "<cmd>Telescope find_files<CR>"),
			button("w", "󰦨  Find Text", "<cmd>Telescope live_grep<CR>"),
			button("r", "  Find Recent", "<cmd>Telescope oldfiles<CR>"),
			button("g", "󰊢  Git", "<cmd>lua _LAZYGIT_TOGGLE()<CR>"),
		},
		opts = {
			spacing = 1,
		},
	}

	local footer = {
		type = "text",
		val = require("alpha.fortune")(),
		opts = { hl = "Comment", position = "center" },
	}

	alpha.setup({
		layout = {
			header_padding,
			header_ascii_art,
			sig,
			{ type = "padding", val = 3 }, -- Quick padding to separate header from buttons
			buttons,
			footer,
		},
		opts = {},
	})
end

return M

