
-- Options
local options = {
  clipboard = 'unnamed,unnamedplus',      --
  cmdheight = 0,                          --
  completeopt = 'menu,menuone,noselect',  --
  cursorline = true,                      --
  emoji = true,                           --
  expandtab = true,                       --
  foldcolumn = '0',                       --
  foldnestmax = 0,                        --
  foldlevel = 99,                         --
  foldlevelstart = 99,                    --
  ignorecase = true,                      --
  laststatus = 3,                         --
  mouse = 'a',                            --
  number = true,                          --
  pumheight = 10,                         --
  relativenumber = true,                  --
  scrolloff= 8,                           --
  shiftwidth = 2,                         --
  showtabline = 2,                        --
  signcolumn = 'yes',                     --
  smartcase= true,                        --
  smartindent = true,                     --
  softtabstop = -1,                       --
  numberwidth = 2,                        --
  splitright = true,                      --
  splitbelow = true,                      --
  swapfile = false,                       --
  tabstop = 2,                            --
  termguicolors = true,                   --
  timeoutlen = 200,                       --
  undofile = true,                        --
  updatetime = 100,                       --
  cindent = true,                         --
  wrap = true,                           --
  writebackup = true,                     --
  autoindent = true,                      --
  backspace= 'indent,eol,start',          --
  backup= false,                          --
  smarttab = true,                        --
  conceallevel= 2,                        --
  concealcursor = '',                     --
  encoding = 'utf-8',                     --
  errorbells = true,                      --
  fileencoding= 'utf-8',                  --
  incsearch= true,                        --
}

-- Globals
--
--
local globals = {
  mapleader = ' ',        --
  maplocalleader = ' ',   --
}

-- Especial options
--
--
vim.opt.shortmess:append('c');           -- 
vim.opt.formatoptions:remove('c');       --
vim.opt.formatoptions:remove('r');       --
vim.opt.formatoptions:remove('o');       --
vim.opt.fillchars:append('stl: ');       --
vim.opt.fillchars:append('eob: ');       --
vim.opt.fillchars:append('fold: ');      --
vim.opt.fillchars:append('foldopen: ');  --
vim.opt.fillchars:append('foldsep: ');   --
vim.opt.fillchars:append('foldclose:'); --

-- Loop set options
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Loop set globas options
for k, v in pairs(globals) do
  vim.g[k] = v
end

-- Highlight on yank
--
--
--
vim.api.nvim_create_autocmd('TextYankPost',
  { callback = function() 
    vim.highlight.on_yank({ 
      higroup = 'IncSearch',
      timeout = 100
    }) 
  end })

