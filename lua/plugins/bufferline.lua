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
			separator_style = "slope",
			indicator = { style = "underline" },
			diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "("..count..")"
            end,
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" }
			},
			offsets = {
				{
					filetype = "NvimTree",
					text = function()
						return vim.fn.getcwd()
					end,
					highlight = "Directory",
					text_align = "left",
					padding = 0
				}
			}
		}
	})
end

return M

