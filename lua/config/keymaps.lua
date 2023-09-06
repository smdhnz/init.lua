vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap

-- expr = 式
-- silent = コマンド非表示
-- noremap = そのキーの本来の機能を呼び出す

-- move
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("x", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("x", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "J", "10j", { silent = true })
map("n", "K", "10k", { silent = true })
map("n", "G", "Gzz", { silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", noremap = true, silent = true })

-- search
map("n", "<esc><esc>", "<cmd>nohlsearch<cr>", { desc = "Escape and clear hlsearch", silent = true })
map(
	"n",
	"<leader><leader>",
	"<CMD>let @/ = '\\<' . expand('<cword>') . '\\>'<CR><CMD>set hlsearch<CR>",
	{ desc = "Highlight", silent = true }
)
