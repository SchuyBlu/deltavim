local servers = {
	"lua_ls",
	"pyright",
	"bashls",
	"clangd",
	"tsserver",
	"rust_analyzer",
	"jdtls",
	"omnisharp",
	"texlab",
	"asm_lsp",
}

local settings = {
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

