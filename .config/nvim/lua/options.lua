-- Neovim configuration of jct301@gmail.com
-- Website: https://neovim.io
-- Dotfiles: https://github.com/jct301/dotfiles

-- Configuration options
local options = {
  clipboard = "unnamed,unnamedplus",
  cmdheight = 0,
  completeopt = "menu,menuone,noselect",
  cursorline = true,
  expandtab = true,
  foldcolumn = "0",
  foldnestmax = 0,
  foldlevel = 99,
  foldlevelstart = 99,
  ignorecase = true,
  laststatus = 3,
  mouse = "a",
  number = true,
  pumheight = 10,
  relativenumber = true,
  scrolloff = 8,
  shiftwidth = 2,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  smarttab = true,
  softtabstop = 2,
  termguicolors = true,
  timeoutlen = 200,
  undofile = true,
  background = "dark",
  updatetime = 100,
  wrap = true,
  writebackup = false,
  autoindent = true,
  backspace = "indent,eol,start",
  backup = false,
  conceallevel = 2,
  concealcursor = "",
  encoding = "utf-8",
  errorbells = false,
  fileencoding = "utf-8",
  incsearch = true,
  showmode = true
}

-- Configuration of globals variables
local globals = {
  mapleader = " ",
  maplocalleader = " "
}

-- Shortmess, formatoptions & fillchars configurations
vim.opt.shortmess:append("c");
vim.opt.formatoptions:remove("c");
vim.opt.formatoptions:remove("r");
vim.opt.formatoptions:remove("o");
vim.opt.fillchars:append("stl: ");
vim.opt.fillchars:append("eob: ");
vim.opt.fillchars:append("fold: ");
vim.opt.fillchars:append("foldopen: ");
vim.opt.fillchars:append("foldsep: ");
vim.opt.fillchars:append("foldclose:");

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

