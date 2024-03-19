local M = {}

function M.config()
	local status, lspconfig = pcall(require, "lspconfig")
	if not status then
		return
	end

	local border = {
		{ '┌', 'FloatBorder' },
		{ '─', 'FloatBorder' },
		{ '┐', 'FloatBorder' },
		{ '│', 'FloatBorder' },
		{ '┘', 'FloatBorder' },
		{ '─', 'FloatBorder' },
		{ '└', 'FloatBorder' },
		{ '│', 'FloatBorder' },
	}

	local handlers = {
		['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	}

	lspconfig.rust_analyzer.setup({
		handlers = handlers
	})
end

return M

