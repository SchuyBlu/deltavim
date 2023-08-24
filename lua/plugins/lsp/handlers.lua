local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
	return
end

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

function M.setup()
	local signs = {
		{ name = "DiagnosticSignError", text = "Err" },
		{ name = "DiagnosticSignWarn", text = "Wrn" },
		{ name = "DiagnosticSignHint", text = "Hnt" },
		{ name = "DiagnosticSignInfo", text = "Inf" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true,
		signs = {
			active = signs,
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
	}

	vim.diagnostic.config(config)
end

return M

