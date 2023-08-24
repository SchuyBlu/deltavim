local M = {}

function M.config()
	local status, mason = pcall(require, "mason")
	if not status then
		return
	end

	local status, mason_lspconfig = pcall(require, "mason-lspconfig")
	if not status then
		return
	end

	local servers = {
		"clangd",
		"pyright",
	}

	local settings = {
		ui = {
			border = "rounded",
		},
		log_level = vim.log.levels.INFO,
		max_concurrent_installers = 4,
	}

	mason.setup(settings)
	mason_lspconfig.setup({
		ensure_installed = servers,
		automatic_installation = true,
	})

	local status, lspconfig = pcall(require, "lspconfig")
	if not status then
		return
	end

	local opts = {}

	for _, server in ipairs(servers) do
		opts = {
			on_attach = require("plugins.lsp.handlers").on_attach,
			capabilities = require("plugins.lsp.handlers").capabilities
		}

		server = vim.split(server, "@")[1]

		lspconfig[server].setup(opts)
	end
end

return M

