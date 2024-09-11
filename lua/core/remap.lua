vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "<C-BS>", "<esc>bciw", { silent = true, desc = "Delete from cursor." })

