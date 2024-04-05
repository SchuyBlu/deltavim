-- Author: Schuy

require("core")
require("setup.lazy_bootstrap")

-- Set up all plugins, see lua/plugins/
require("lazy").setup("plugins")
vim.cmd.colorscheme("everforest")

