local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate"
}

function M.config()
	local status, treesitter = pcall(require, "nvim-treesitter.configs")
	if not status then
		return
	end


	treesitter.setup({
		ensure_installed = {
			"c",
			"cpp",
			"c_sharp",
			"java",
			"rust",
			"lua",
			"python",
			"javascript",
			"perl",
			"bash",
			"css",
			"html",
			"vim",
			"json",
		},
		sync_install = true,
		auto_install = true,
		highlight = { enable = true },
	})
end

return M

