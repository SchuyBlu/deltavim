local M = {
	"CRAG666/code_runner.nvim",
	event = "VeryLazy",
	dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
	local status, code_runner = pcall(require, "code_runner")
	if not status then
		return
	end

	local home = vim.fn.expand("~")

	code_runner.setup({
		mode = "toggleterm",

		project_path = vim.fn.expand("~/.config/nvim/project_manager.json"),

		filetype = {
			awk = "awk -f $file",
			riscv = {
				"cd $dir &&",
				"java -jar " .. home .. "/bin/rars.jar $file"
			},
			c = function(...) 
				local c_base = {
					"cd $dir &&",
					"gcc $fileName -o",
					"/tmp/$fileNameWithoutExt",
				}
				local c_exec = {
					"&& /tmp/$fileNameWithoutExt",
					"&& rm /tmp/$fileNameWithoutExt",
				}
				vim.ui.input({ prompt = "Add more args: "}, function(input)
					c_exec[1] = c_exec[1] .. " " .. input
					vim.print(vim.tbl_extend("force", c_base, c_exec))
					require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
				end)
			end,
			java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
			kotlin = {
				"cd $dir &&",
				"kotlic $fileName -include-runtime -d $fileNameWithoutExt.jar &&",
				"java -jar $fileNameWithoutExt.jar"
			},
			javascript = "node %",
			list = "clisp $file",
			lua = "luajit $file",
			perl = "cd $dir && perl $file",
			python = "cd $dir && python3 $file",
			rust = "cd $dir && cargo run",
			sh = "cd $dir && bash $file",
		},
	})
end

return M

