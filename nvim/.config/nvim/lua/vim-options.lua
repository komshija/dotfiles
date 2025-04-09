local function map(keys, func, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { desc = desc })
end

-- Options --
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

vim.wo.number = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- Key mappings -- 
map('<c-k>', ':wincmd k<CR>', "Move to pan up")
map('<c-j>', ':wincmd j<CR>', "Move to pan down")
map('<c-h>', ':wincmd h<CR>', "Move to pan left")
map('<c-l>', ':wincmd l<CR>', "Move to pan right")

map('<leader>h', ':nohlsearch<CR>', "Clear hightlight")

map('<esc>', [[<C-\><C-n]], "escape for terminal", 't')
map('jk', [[<C-\><C-n]], "easy escape for terminal", 't')

-- Theme config

-- vim.cmd.colorscheme "github_dark_colorblind"
