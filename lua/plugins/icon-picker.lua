local M = {
	"ziontee113/icon-picker.nvim",
	dependencies = {
		{
			"stevearc/dressing.nvim",
			opts = {},
		},
	},
}

function M.config()
	local status, icons = pcall(require, "icon-picker")
	if not status then
		return
	end

	icons.setup({ disable_legacy_commands = true })
end

return M

