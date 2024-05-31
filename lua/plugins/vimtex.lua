return {
	"lervag/vimtex",
	enabled = true,
	ft = "tex",
	init = function()
		vim.g.tex_flavor = "latex"
		vim.g.vimtex_view_method = "zathura"
		vim.g.tex_conceal = "abdmg"
	end,
}
