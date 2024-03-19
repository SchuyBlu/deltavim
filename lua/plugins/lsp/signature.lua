local M = {}

function M.config()
	local status, signature = pcall(require, "lsp_signature")
	if not status then
		return
	end

	local opts = {}
	local cfg = {
		debug = false,
		log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log",
		verbose = false,
		bind = true,
		doc_lines = 10,
		floating_window = true,
		floating_window_above_current_line = true,
		fix_pos = false,
		hint_enable = false,
		hint_scheme = "Comment",
		use_lspsaga = false,
		hi_parameter = "LspSignatureActiveParameter",
		max_height = 12,
		max_width = 120,
		always_trigger = false,
		auto_close_after = nil,
		extra_trigger_chars = {},
		zindex = 200,
		padding = " ",
		transparency = nil,
		time_interval = 200,
		toggle_key = nil,
	}

	signature.setup(cfg)

	signature.on_attach(cfg)
end

return M
