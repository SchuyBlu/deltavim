vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.spell = true
vim.opt_local.conceallevel = 1

local function file_exists(filename)
	local file = io.open(filename, "r+")
	if file ~= nil then
		io.close(file)
		return true
	else
		return false
	end
end

function inkscape_run()
	local filename = vim.fn.getreg('f')
	
	filename = filename:gsub("%s+", "-")

	local dir = vim.fn.getcwd()
	local path = dir .. "/figures/" .. filename .. ".svg"

	if file_exists(path) then
		os.execute("inkscape " .. path)
		return
	end

	local options = '"file-new:; export-filename:' .. path .. '; export-do"'
	local cmd = "inkscape --actions=" .. options
	os.execute(cmd)
	os.execute("inkscape " .. path)
end

local function tex_format()
	local filename = vim.fn.getreg('f'):gsub("%s+", "-")
	local path = vim.fn.getcwd() .. "/figures/" .. filename .. ".svg"

	local tex_stream = string.format(
	"\\begin{figure}[htbp]",
	"\\centering{",
	"	\\resizebox{75mm}{!}{\\input{./figures/" .. path .. "}}",
	"}",
	"\\end{figure}"
	)
	return tex_stream
end

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

