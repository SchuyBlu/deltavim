local datapath = vim.fn.stdpath("data")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand("~") .. '/workspace/java/' .. project_name

local bundles = {
	vim.fn.glob(datapath .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
};
vim.list_extend(vim.split(vim.fn.glob(datapath .. "/mason/packages/java-test/extension/server/*.jar", 1), "\n"))


local config = {
	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		'-jar', datapath .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',

		'-configuration', datapath .. '/mason/packages/jdtls/config_linux',

		'-data', workspace_dir,
	},
	init_options = {
		bundles = bundles,
	},
}

require('jdtls').start_or_attach(config)
