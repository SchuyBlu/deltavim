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

	local mappings = {
		{ "<localleader>", expr = false, group = "VimTeX", nowait = false, remap = false },
		{ "<localleader>e", "<cmd>VimtexErrors<cr>", desc = "Show Errors", expr = false, nowait = false, remap = false },
		{ "<localleader>i", "<cmd>VimtexInfo<cr>", desc = "VimTeX Info", expr = false, nowait = false, remap = false },
		{ "<localleader>l", "<cmd>VimtexClean<cr>", desc = "Clean Auxiliary Files", expr = false, nowait = false, remap = false },
		{ "<localleader>p", "<cmd>VimtexCompile<cr>", desc = "Compile and Preview", expr = false, nowait = false, remap = false },
		{ "<localleader>r", "<cmd>VimtexReload<cr>", desc = "Reload", expr = false, nowait = false, remap = false },
		{ "<localleader>s", "<cmd>VimtexStop<cr>", desc = "Stop Compilation", expr = false, nowait = false, remap = false },
		{ "<localleader>t", "<cmd>VimtexTocToggle<cr>", desc = "Toggle ToC", expr = false, nowait = false, remap = false },
		{ "<localleader>v", "<cmd>VimtexView<cr>", desc = "View PDF", expr = false, nowait = false, remap = false },
	}

	which_key.add(mappings)
end

