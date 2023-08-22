local M = {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-tree.lua"
	}
}

function M.config()
	local status, bufferline = pcall(require, "bufferline")
	if not status then
		return
	end

	bufferline.setup({
		options = {
			tab_size = 22,
			separator_style = "thick",
			hover = {
				enabled = true,
				delay = 100,
				reveal = { "close" }
			},
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "left",
					padding = 1
				}
			}
		}
	})
end

return M

