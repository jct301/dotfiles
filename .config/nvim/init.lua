-- Settings
local options = {
  clipboard = 'unnamed,unnamedplus',
  cmdheight = 0,
  completeopt = 'menu,menuone,noselect',
  cursorline = true,
  emoji = true,
  expandtab = true,
  foldcolumn = '0',
  foldnestmax = 0,
  foldlevel = 99,
  foldlevelstart = 99,
  ignorecase = true,
  laststatus = 3,
  mouse = 'a',
  number = true,
  pumheight = 10,
  relativenumber = true,
  scrolloff= 8,
  shiftwidth = 2,
  showtabline = 2,
  signcolumn = 'yes',
  smartcase= true,
  smartindent = true,
  softtabstop = -1,
  numberwidth = 2,
  splitright = true,
  splitbelow = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 200,
  undofile = true,
  updatetime = 100,
  cindent = true,
  textwidth = 300,
  wrap = true,
  writebackup = true,
  autoindent = true,
  backspace= 'indent,eol,start',
  backup= false,
  smarttab = true,
  conceallevel= 2,
  concealcursor = '',
  encoding = 'utf-8',
  errorbells = true,
  fileencoding= 'utf-8',
  incsearch= true,
}

local globals = {
  mapleader = ' ',
  maplocalleader = ' ',
  speeddating_no_mappings = 1,
}

vim.opt.shortmess:append('c');
vim.opt.formatoptions:remove('c');
vim.opt.formatoptions:remove('r');
vim.opt.formatoptions:remove('o');
vim.opt.fillchars:append('stl: ');
vim.opt.fillchars:append('eob: ');
vim.opt.fillchars:append('fold: ');
vim.opt.fillchars:append('foldopen: ');
vim.opt.fillchars:append('foldsep: ');
vim.opt.fillchars:append('foldclose:');

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost',
  { callback = function() 
    vim.highlight.on_yank({ 
      higroup = 'IncSearch',
      timeout = 100
    }) 
  end })

-- Plugins list
local plugins = {
  -- Autoclose
  { 
    'm4xshen/autoclose.nvim',
    event = 'VeryLazy',
    opts = { enabled = true} 
  },

  -- Autosave
  {
    'Pocco81/auto-save.nvim',
    event = 'VeryLazy',
    opts = {
      enabled = true,
      execution_message = {
        message = function()
          return 'Save at ' .. vim.fn.strftime('%H:%M:%S')
        end,
        dim = 0.18,
        cleaning_interval = 1250,
      },
      trigger_events = { 'InsertLeave', 'TextChanged' },
      condition = function(buf)
        local fn = vim.fn
        local utils = require('auto-save.utils.data')
        if
          fn.getbufvar(buf, '&modifiable') == 1 and
          utils.not_in(fn.getbufvar(buf, '&filetype'), {}) then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      debounce_delay = 135,
    }
  },

  -- Bufdel
  'ojroques/nvim-bufdel',

  -- Colorscheme
  'RRethy/nvim-base16',
  
  -- Cinnamon
  {
    'declancm/cinnamon.nvim',
    event = 'VeryLazy',
    opts = {
      extra_keymaps = true,
      extended_keymaps = true,
      override_keymaps = true,
      always_scroll = true,
      max_length = 500,
      scroll_limit = -1,
    }
  },

  -- Berbecue
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      enabled = true
    }
  },
  -- Cmp
  {
    'hrsh7th/nvim-cmp',
    event = 'VeryLazy',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'f3fora/cmp-spell',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local compare = require('cmp.config.compare')
      cmp.setup({
        -- Snippets
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        -- Completion
        completion = {
          completeopt = 'menu,noselect,noinsert'
        },
        -- Key mapping
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ['<C-n>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          -- Tab mapping
          ['<Tab>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {'i', 's'}),
          ['<S-Tab>'] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {'i', 's'}),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip', option = {
            use_show_condition=false}
          },
          { name = 'path' },
          { name = 'buffer' },
          { name = 'spell' },
        },
        -- Sorting
        sorting = {
          priority_weight = 2,
          comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
      })
      require('cmp').setup.filetype(
        {'dap-repl', 'dapui-watched'},
        { sources = { { name = 'dap'} } } )
    end
  },

  -- Barbar
  {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      animation = true,
      insert_at_start = true,
    },
  },

  -- Comment
  { 'numToStr/Comment.nvim' , lazy = false },

  -- Conform
  {
    'stevearc/conform.nvim',
    opts = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { { 'prettierd', 'prettier' } },
      markdown = { { 'prettierd', 'prettier' } },
      typescript = { 'eslint_d' },
      sh = { 'shfmt' },
      bash = { 'shfmt' }
    },
     config = function()
        vim.api.nvim_create_user_command('Reformat', function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ['end'] = { args.line2, end_line:len() },
                }
            end
            require('conform').format({ async = true, lsp_fallback = true, range = range })
        end, { range = true })
    end
  },
  -- Dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
    'rcarriga/nvim-dap-ui',
    'mfussenegger/nvim-dap-python',
    'folke/neodev.nvim',
    'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      require('telescope').load_extension('dap')
      local dap, dapui = require('dap'), require('dapui')
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
      require('neodev').setup({
        library = { plugins = { 'nvim-dap-ui' }, types = true },
      })
      require('plugins.dbg.python')
      require('plugins.dbg.rust')
      require('nvim-dap-virtual-text').setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = true,
        only_first_definition = true,
        all_references = true,
        filter_references_pattern = '<module',
        virt_text_pos = 'eol',
        all_frames = true,
        virt_lines = true,
        virt_text_win_col = nil
      })
    end
  },

  -- Diffview
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local actions = require('diffview.actions')
      require('diffview').setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { 'git' },
        use_icons = true,
        icons = {
          folder_closed = '',
          folder_open = '',
        },
        signs = {
          fold_closed = '',
          fold_open = '',
        },
        file_panel = {
          listing_style = 'tree',
          tree_options = {
            flatten_dirs = true,
            folder_statuses = 'only_folded',
          },
          win_config = {
            position = 'left',
            width = 35,
          },
        },
        commit_log_panel = {
          win_config = {},
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
          disable_defaults = false,
          view = {
            ['<tab>'] = actions.select_next_entry,
            ['<s-tab>'] = actions.select_prev_entry,
            ['gf'] = actions.goto_file,
            ['<C-w><C-f>'] = actions.goto_file_split,
            ['<C-w>gf'] = actions.goto_file_tab,
            ['<leader>e'] = actions.focus_files,
            ['<leader>b'] = actions.toggle_files,
          },
          file_panel = {
            ['j'] = actions.next_entry,
            ['<down>'] = actions.next_entry,
            ['k'] = actions.prev_entry,
            ['<up>'] = actions.prev_entry,
            ['<cr>'] = actions.select_entry,
            ['o'] = actions.select_entry,
            ['<2-LeftMouse>'] = actions.select_entry,
            ['-'] = actions.toggle_stage_entry,
            ['S'] = actions.stage_all,
            ['U'] = actions.unstage_all,
            ['X'] = actions.restore_entry,
            ['R'] = actions.refresh_files,
            ['L'] = actions.open_commit_log,
            ['<c-b>'] = actions.scroll_view(-0.25),
            ['<c-f>'] = actions.scroll_view(0.25),
            ['<tab>'] = actions.select_next_entry,
            ['<s-tab>'] = actions.select_prev_entry,
            ['gf'] = actions.goto_file,
            ['<C-w><C-f>'] = actions.goto_file_split,
            ['<C-w>gf'] = actions.goto_file_tab,
            ['i'] = actions.listing_style,
            ['f'] = actions.toggle_flatten_dirs,
            ['<leader>e'] = actions.focus_files,
            ['<leader>b'] = actions.toggle_files,
          },
          file_history_panel = {
            ['g!'] = actions.options,
            ['<C-A-d>'] = actions.open_in_diffview,
            ['y'] = actions.copy_hash,
            ['L'] = actions.open_commit_log,
            ['zR'] = actions.open_all_folds,
            ['zM'] = actions.close_all_folds,
            ['j'] = actions.next_entry,
            ['<down>'] = actions.next_entry,
            ['k'] = actions.prev_entry,
            ['<up>']= actions.prev_entry,
            ['<cr>']= actions.select_entry,
            ['o'] = actions.select_entry,
            ['<2-LeftMouse>'] = actions.select_entry,
            ['<c-b>'] = actions.scroll_view(-0.25),
            ['<c-f>'] = actions.scroll_view(0.25),
            ['<tab>'] = actions.select_next_entry,
            ['<s-tab>'] = actions.select_prev_entry,
            ['gf'] = actions.goto_file,
            ['<C-w><C-f>']= actions.goto_file_split,
            ['<C-w>gf'] = actions.goto_file_tab,
            ['<leader>e'] = actions.focus_files,
            ['<leader>b'] = actions.toggle_files,
          },
          option_panel = {
            ['<tab>'] = actions.select_entry,
            ['q'] = actions.close,
          },
        },
      })
    end,
  },
  -- Dressing
  'stevearc/dressing.nvim',

  -- Feline 
  {
    "freddiehaddad/feline.nvim",
    event = "VeryLazy",
    dependencies = {
      "gitsigns.nvim",
      "nvim-web-devicons"
    },
    config = function()
      local lsp = require('feline.providers.lsp')
      local vi_mode_utils = require('feline.providers.vi_mode')
      local force_inactive = {
        filetypes = {},
        buftypes = {},
        bufnames = {}
      }
      local components = {
        active = { {}, {}, {} },
        inactive = { {}, {}, {} },
      }
      local colors = {
        bg = '#282828',
        black = '#282828',
        yellow = '#d8a657',
        cyan = '#89b482',
        oceanblue = '#45707a',
        green = '#a9b665',
        orange = '#e78a4e',
        violet = '#d3869b',
        magenta = '#c14a4a',
        white = '#a89984',
        fg = '#a89984',
        skyblue = '#7daea3',
        red = '#ea6962',
      }
      local vi_mode_colors = {
        NORMAL = 'green',
        OP = 'green',
        INSERT = 'red',
        VISUAL = 'skyblue',
        LINES = 'skyblue',
        BLOCK = 'skyblue',
        REPLACE = 'violet',
        ['V-REPLACE'] = 'violet',
        ENTER = 'cyan',
        MORE = 'cyan',
        SELECT = 'orange',
        COMMAND = 'green',
        SHELL = 'green',
        TERM = 'green',
        NONE = 'yellow'
      }
      local vi_mode_text = {
        NORMAL = '<|',
        OP = '<|',
        INSERT = '|>',
        VISUAL = '<>',
        LINES = '<>',
        BLOCK = '<>',
        REPLACE = '<>',
        ['V-REPLACE'] = '<>',
        ENTER = '<>',
        MORE = '<>',
        SELECT = '<>',
        COMMAND = '<|',
        SHELL = '<|',
        TERM = '<|',
        NONE = '<>'
      }
      force_inactive.filetypes = {
        'NvimTree',
        'dbui',
        'packer',
        'startify',
        'fugitive',
        'fugitiveblame'
      }
      force_inactive.buftypes = {
        'terminal'
      }
      components.active[1][1] = {
        provider = ' NV ',
        hl = function()
          local val = {}
          val.bg = vi_mode_utils.get_mode_color()
          val.fg = 'black'
          val.style = 'bold'
          return val
        end,
        right_sep = ' '
      }
      components.active[1][2] = {
        provider = function()
          return vi_mode_text[vi_mode_utils.get_vim_mode()]
        end,
        hl = function()
          local val = {}
          val.fg = vi_mode_utils.get_mode_color()
          val.bg = colors.bg
          val.style = 'bold'
          return val
        end,
        right_sep = ' '
      }
      components.active[1][3] = {
        provider = function()
          return vim.fn.expand("%:F")
        end,
        hl = {
          fg = 'white',
          bg = colors.bg,
          style = 'bold'
        },
        right_sep = {
          str = ' > ',
          hl = {
            fg = 'white',
            bg = colors.bg,
            style = 'bold'
          },
        }
      }
      components.active[2][1] = {
        provider = 'git_branch',
        hl = {
          fg = 'yellow',
          bg = colors.bg,
          style = 'bold'
        }
      }
      components.active[2][2] = {
        provider = 'git_diff_added',
        hl = {
          fg = 'green',
          bg = colors.bg,
          style = 'bold'
        }
      }
      components.active[2][3] = {
        provider = 'git_diff_changed',
        hl = {
          fg = 'orange',
          bg = colors.bg,
          style = 'bold'
        }
      }
      components.active[2][4] = {
        provider = 'git_diff_removed',
        hl = {
          fg = 'red',
          bg = colors.bg,
          style = 'bold'
        },
      }
      components.active[2][5] = {
        provider = 'diagnostic_errors',
        enabled = function() 
          return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
        end,
        hl = {
          fg = 'red',
          style = 'bold'
        }
      }
      components.active[2][6] = {
        provider = 'diagnostic_warnings',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
        hl = {
          fg = 'yellow',
          style = 'bold'
        }
      }
      components.active[2][7] = {
        provider = 'diagnostic_hints',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
        hl = {
          fg = 'cyan',
          style = 'bold'
        }
      }
      components.active[2][8] = {
        provider = 'diagnostic_info',
        enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
        hl = {
          fg = 'skyblue',
          style = 'bold'
        }
      }
      components.active[3][1] = {
        provider = 'lsp_client_names',
        hl = {
          fg = 'yellow',
          bg = colors.bg,
          style = 'bold'
        },
        right_sep = ' '
      }
      components.active[3][2] = {
        provider = function()
          local filename  = vim.fn.expand('%:t')
          local extension = vim.fn.expand('%:e')
          local icon = require 'nvim-web-devicons'.get_icon(filename, extension)
          if icon == nil then
            icon = ''
          end
          return icon
        end,
        hl = function()
          local val        = {}
          local filename   = vim.fn.expand('%:t')
          local extension  = vim.fn.expand('%:e')
          local icon, name = require 'nvim-web-devicons'.get_icon(filename, extension)
          if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
          else
            val.fg = 'white'
          end
          val.bg = colors.bg
          val.style = 'bold'
          return val
        end,
        right_sep = ' '
      }
      components.active[3][3] = {
        provider = 'file_type',
        hl = function()
          local val        = {}
          local filename   = vim.fn.expand('%:t')
          local extension  = vim.fn.expand('%:e')
          local icon, name = require 'nvim-web-devicons'.get_icon(filename, extension)
          if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
          else
            val.fg = 'white'
          end
          val.bg = colors.bg
          val.style = 'bold'
          return val
        end,
        right_sep = ' '
      }
      components.active[3][4] = {
        provider = 'file_size',
        enabled = function() 
          return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
        hl = {
          fg = 'skyblue',
          bg = colors.bg,
          style = 'bold'
        },
        right_sep = ' '
      }
      components.active[3][5] = {
        provider = function() return 
          '' .. vim.bo.fileformat:upper() .. '' end,
        hl = {
          fg = 'white',
          bg = colors.bg,
          style = 'bold'
        },
        right_sep = ' '
      }
      components.active[3][6] = {
        provider = 'file_encoding',
        hl = {
          fg = 'white',
          bg = colors.bg,
          style = 'bold'
        },
        right_sep = ' '
      }
      components.active[3][7] = {
        provider = function()
          return ' ' .. tostring(vim.fn.wordcount().words)
        end,
        hl = {
          fg = 'yellow',
          bg = colors.bg,
        },
        right_sep = ' '
      }
      components.active[3][8] = {
        provider = 'position',
        hl = {
          fg = 'white',
          bg = colors.bg,
          style = 'bold'
        },
        right_sep = ' '
      }
      components.active[3][9] = {
        provider = 'line_percentage',
        hl = {
          fg = 'white',
          bg = colors.bg,
          style = 'bold'
        },
        right_sep = ' '
      }
      components.active[3][10] = {
        provider = 'scroll_bar',
        hl = {
          fg = 'yellow',
          bg = colors.bg,
        },
      }
      components.inactive[1][1] = {
        provider = 'file_type',
        hl = {
          fg = 'black',
          bg = 'cyan',
          style = 'bold'
        },
        left_sep = {
          str = ' ',
          hl = {
            fg = 'NONE',
            bg = 'cyan'
          }
        },
        right_sep = {
          {
            str = ' ',
            hl = {
              fg = 'NONE',
              bg = 'cyan'
            }
          },
          ' '
        }
      }
      require('feline').setup({
        theme = colors,
        default_bg = colors.bg,
        default_fg = colors.fg,
        vi_mode_colors = vi_mode_colors,
        components = components,
        force_inactive = force_inactive,
      })
    end,
  },
 
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
 }

-- Plugins manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup(plugins)

-- Colorscheme
-- Uncomment just ONE of following colorscheme!
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-3024')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-apathy')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-apprentice')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-ashes')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-cave')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-cave-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-dune')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-dune-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-estuary')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-estuary-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-forest')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-forest-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-heath')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-heath-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-lakeside')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-lakeside-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-plateau')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-plateau-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-savanna')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-savanna-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-seaside')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-seaside-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-sulphurpool')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atelier-sulphurpool-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-atlas')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-ayu-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-ayu-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-ayu-mirage')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-bespin')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-bathory')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-burzum')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-dark-funeral')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-gorgoroth')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-immortal')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-khold')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-marduk')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-mayhem')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-nile')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-black-metal-venom')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-blueforest')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-blueish')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-brewer')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-bright')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-brogrammer')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-brushtrees')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-brushtrees-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-catppuccin')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-catppuccin-frappe')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-catppuccin-latte')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-catppuccin-macchiato')
local ok, _ = pcall(vim.cmd, 'colorscheme base16-catppuccin-mocha')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-chalk')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-circus')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-classic-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-classic-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-codeschool')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-colors')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-cupcake')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-cupertino')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-da-one-black')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-da-one-gray')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-da-one-ocean')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-da-one-paper')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-da-one-sea')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-da-one-white')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-danqing')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-darcula')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-darkmoss')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-darktooth')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-darkviolet')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-decaf')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-default-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-default-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-dirtysea')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-dracula')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-edge-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-edge-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-eighties')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-embers')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-emil')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-equilibrium-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-equilibrium-gray-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-equilibrium-gray-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-equilibrium-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-espresso')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-eva')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-eva-dim')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-evenok-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-everforest')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-flat')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-framer')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-fruit-soda')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gigavolt')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-github')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-google-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-google-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gotham')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-grayscale-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-grayscale-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-greenscreen')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruber')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-dark-hard')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-dark-medium')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-dark-pale')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-dark-soft')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-light-hard')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-light-medium')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-light-soft')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-material-dark-hard')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-material-dark-medium')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-material-dark-soft')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-material-light-hard')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-material-light-medium')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-material-light-soft')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-hardcore')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-harmonic-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-harmonic-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-heetch')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-heetch-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-helios')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-hopscotch')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-horizon-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-horizon-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-horizon-terminal-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-horizon-terminal-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-humanoid-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-humanoid-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-ia-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-ia-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-icy')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-irblack')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-isotope')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-kanagawa')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-katy')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-kimber')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-lime')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-macintosh')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-marrakesh')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-materia')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-material')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-material-darker')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-material-lighter')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-material-palenight')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-material-vivid')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-mellow-purple')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-mexico-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-mocha')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-monokai')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-mountain')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-nebula')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-nord')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-nova')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-ocean')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-oceanicnext')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-one-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-onedark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-outrun-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-pandora')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-papercolor-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-papercolor-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-paraiso')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-pasque')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-phd')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-pico')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-pinky')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-pop')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-porple')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-primer-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-primer-dark-dimmed')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-primer-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-purpledream')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-qualia')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-railscasts')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-rebecca')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-rose-pine')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-rose-pine-dawn')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-rose-pine-moon')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-sagelight')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-sakura')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-sandcastle')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-seti')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-shades-of-purple')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-shadesmear-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-shadesmear-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-shapeshifter')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-silk-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-silk-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-snazzy')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarflare')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarflare-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarized-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarized-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-spaceduck')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-spacemacs')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-standardized-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-standardized-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-stella')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-still-alive')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-summercamp')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-summerfruit-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-summerfruit-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-synth-midnight-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-synth-midnight-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tango')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tender')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-city-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-city-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-city-terminal-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-city-terminal-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-night-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-night-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-night-storm')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-night-terminal-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-night-terminal-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyo-night-terminal-storm')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyodark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tokyodark-terminal')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tomorrow')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tomorrow-night')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tomorrow-night-eighties')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tube')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-twilight')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-unikitty-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-unikitty-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-unikitty-reversible')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-uwunicorn')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-vice')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-vulcan')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-windows-10')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-windows-10-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-windows-95')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-windows-95-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-windows-highcontrast')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-windows-highcontrast-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-windows-nt')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-windows-nt-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-woodland')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-xcode-dusk')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-zenburn')

-- Keymaps
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Barbar
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
