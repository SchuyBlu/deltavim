local M = {
	"akinsho/toggleterm.nvim"
}

function M.config()
	local status, tterm = pcall(require, "toggleterm")
	if not status then
		return
	end

	tterm.setup({
		direction = "float",
		shade_terminals = true,
	})

	function _G.set_terminal_keymaps()
		local opts = { noremap = true }
		vim.api.nvim_buf_set_keymap(0, "t", "<m-c>", [[<C-\><C-n><C-W>q]], opts)
	end

	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	local Terminal = require("toggleterm.terminal").Terminal

	function exists(file)
		local ok, err, code = os.rename(file, file)
		if not ok then
			if code == 13 then
				return true
			end
		end
		return ok, err
	end

	local function _TMUX_TOGGLE()
		local venv = Terminal:new({
			cmd = "tmux",
			hidden = true,
			direction = "float",
			shade_terminals = true,
			on_open = function(_)
				vim.cmd("startinsert!")
			end,
			on_close = function(_)
			end,
		})
		venv:toggle()
	end

	vim.api.nvim_create_user_command("TmuxToggle", _TMUX_TOGGLE, {})

	function _LAZYGIT_TOGGLE()
		local lazy = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			shade_terminals = true,
			on_open = function(_)
				vim.cmd("startinsert!")
			end,
			on_close = function(_)
			end,
		})
		lazy:toggle()
	end

	function _TOP_TOGGLE()
		local top = Terminal:new({
			cmd = "top",
			hidden = true,
			direction = "float",
			shade_terminals = true,
		})
		top:toggle()
	end
end

return M

