vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.spell = true
vim.opt_local.conceallevel = 1

local status, which_key = pcall(require, "which-key")
if status then
	local opts = {
		mode = "n",
		prefix = "<localleader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
		expr = false
	}

	local mappings = {
        name = "VimTeX",
        p = { "<cmd>VimtexCompile<cr>", "Compile and Preview" },
        i = { "<cmd>VimtexInfo<cr>", "VimTeX Info" },
        t = { "<cmd>VimtexTocToggle<cr>", "Toggle ToC" },
        v = { "<cmd>VimtexView<cr>", "View PDF" },
        r = { "<cmd>VimtexReload<cr>", "Reload" },
        s = { "<cmd>VimtexStop<cr>", "Stop Compilation" },
        e = { "<cmd>VimtexErrors<cr>", "Show Errors" },
        l = { "<cmd>VimtexClean<cr>", "Clean Auxiliary Files" },
	}

	which_key.register(mappings, opts)
end


