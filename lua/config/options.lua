local opt = vim.opt
local g = vim.g

opt.splitbelow = true
opt.smartcase = true
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.autoindent = true
opt.termguicolors = true
opt.showmode = false
opt.number = true
opt.relativenumber = false
opt.expandtab = true
opt.smarttab = false
opt.smartindent = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.shiftround = true
opt.foldenable = false
opt.updatetime = 200
opt.swapfile = false
opt.undofile = true
opt.showtabline = 0
opt.mouse = "a"
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.wrap = false
opt.list = true
opt.fillchars = { eob = " " }
opt.lazyredraw = true
opt.laststatus = 3
opt.confirm = true
opt.conceallevel = 3
opt.cmdheight = 0
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.autowrite = true
opt.splitkeep = "screen"
opt.completeopt = "menu,menuone,noselect,noinsert"
opt.timeout = true
opt.timeoutlen = 500
vim.o.signcolumn = "yes"
vim.diagnostic.config({
	underline = true,
	virtual_text = false,
})
-- vim.fn.sign_define("DiagnosticSignError", { text = "🔴" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = "🟠" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = "🟡" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "🟢" })

-- Disable certain builtins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_logipat = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_fzf = 1
-- Disable provider warnings in the healthcheck
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
-- Set matchparen options for vim-matchup
g.matchup_matchparen_offscreen = { method = "status_manual " }
