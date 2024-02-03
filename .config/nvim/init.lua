-- Copyright (c) 2024-Present Jean Carlos T. R.

-- Permission is hereby granted, free of charge, to any person 
-- obtaining a copy of this software and associated documentation
-- files (the "Software"), to deal in the Software without 
-- restriction, including without limitation the rights to use, copy,
-- modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be 
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
-- OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
-- HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-- WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.

--------------------------------------------
-- BASE
--------------------------------------------
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


--------------------------------------------
-- PLUGINS
--------------------------------------------

-- Plugins list
local plugins = {
--------------------------------------------
  -- Colorschemes
--------------------------------------------

  -- Catppuccin https://github.com/catppuccin/nvim
  -- latte, frappe, mocha, macchiato
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local options = {
        flavour = "macchiato",
        background = {
          light = "latte",
          dark = "mocha"
        },
        transparent_background = false,
        show_end_of_buffer = true,
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.05
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "bold", "italic" },
          functions = { "bold", "italic" },
          keywords = { "bold" },
          strings = { "italic" },
          variables = { "bold" },
          numbers = { "bold" },
          booleans = { "bold", "italic" },
          properties = { "bold" },
          types = { },
          operators = { }
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        }
      }
      require("catppuccin").setup(options)
      vim.cmd.colorscheme("catppuccin")
    end
  },
  
  -- Autoclose https://github.com/m4xshen/autoclose.nvim
  { 
    "m4xshen/autoclose.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true
    }
  },

  -- Autopairs https://github.com/windwp/nvim-autopairs
  { 
    "windwp/nvim-autopairs", 
    event = "InsertEnter",
    opts = {
      enabled = true
    }
  },

  -- Autosave https://github.com/pocco81/auto-save.nvim
  {
    "Pocco81/auto-save.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      execution = {
        message = function()
          return "Autosae at " .. vim.fn.strftime("%H:%M:%S")
        end,
        dim = 0.18,
        cleaning_interval = 1250
      },
      trigger_events = { "InsertLeave", "TextChanged" },
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if
          fn.getbufvar(buf, "&modifiable") == 1 and
          utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true
        end
        return false
      end,
      write_all_buffers = true,
      debounce_delay = 135,
      callbacks = {
        enabling = nil,
        disabling = nil,
        before_asserting_save = nil,
        before_saving = nil,
        after_saving = nil
      }
    }
  },
  "ojroques/nvim-bufdel",
  { 
    "declancm/cinnamon.nvim", 
    event = "VeryLazy", 
    opts = {
      extra_keymaps = true,
      extended_keymaps = true,
      override_keymaps = true,
      always_scroll = true,
      max_lenght = 10000000,
      scroll_limit = -1
    }
  },

  -- Autocompletion nvim-cmp https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "rafamadriz/friendly-snippets"
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local compare = require("cmp.config.compare")
      cmp.setup({
        -- load snippet support
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        -- completion settings
        completion = {
          completeopt = "menuone,noselect,noinsert"
        },
        -- keymappins
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ['<C-n>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ['<CR>'] = cmp.mapping.confirm { select = false},
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          -- Tab mapping
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {"i", "s"}),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {"i", "s"}),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip', option = {use_show_condition=false}},
          { name = 'path' },
          { name = 'buffer' },
          { name = 'spell' },
        },
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
      require("cmp").setup.filetype(
	{"dap-repl", "dapui-watched"},
	{ 
          sources = {{ name = "dap" }}
        }
      )	
    end
  },
  {
    "willothy/nvim-cokeline",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons"
    },
    config = function()
      local get_hex = require('cokeline.hlgroups').get_hl_attr
      local mappings = require('cokeline.mappings')
      local comments_fg = get_hex('Comment', 'fg')
      local errors_fg = get_hex('DiagnosticError', 'fg')
      local warnings_fg = get_hex('DiagnosticWarn', 'fg')
      local red = vim.g.terminal_color_1
      local yellow = vim.g.terminal_color_3
      local abg = get_hex("Normal", 'bg')
      local nbg = "#6E665A"
      local sbg = "#D8A657"
      local components = {
        space = {
          text = ' ',
          truncation = { priority = 1 },
        },
        two_spaces = {
          text = '  ',
          truncation = { priority = 1 },
        },
        separator = {
          text = ' ',
          truncation = { priority = 1 },
          fg = abg,
          bg = abg,
        },
        devicon = {
          text = function(buffer)
            return
              (mappings.is_picking_focus() or
              mappings.is_picking_close())
              and buffer.pick_letter .. ' '
              or buffer.devicon.icon
          end,
          fg = function(buffer)
            return
               (mappings.is_picking_focus() and yellow)
               or (mappings.is_picking_close() and red)
               or buffer.devicon.color
          end,
          style = function(_)
            return
              (mappings.is_picking_focus() or
              mappings.is_picking_close())
              and 'italic,bold'
              or nil
          end,
          truncation = { priority = 1 }
        },
        index = {
          text = function(buffer)
            return buffer.index .. ': '
          end,
          fg = function(buffer)
            return buffer.is_focused and nbg or "#FFFFFF"
          end,
          truncation = { priority = 1 }
        },
        unique_prefix = {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          fg = function(buffer)
            return buffer.is_focused and nbg or "#FFFFFF"
          end,
          style = 'italic',
          truncation = {
            priority = 3,
            direction = 'left',
          },
        },
        filename = {
          text = function(buffer)
            return buffer.filename
          end,
          style = function(buffer)
            return
              ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
              and 'bold,underline')
              or (buffer.is_focused and 'bold')
              or (buffer.diagnostics.errors ~= 0 and 'underline')
              or nil
          end,
          fg = function(buffer)
            return buffer.is_focused and nbg or "#FFFFFF"
          end,
          truncation = {
            priority = 2,
            direction = 'left',
          },
        },
        diagnostics = {
          text = function(buffer)
            return
              (buffer.diagnostics.errors ~= 0 and
              '  ' .. buffer.diagnostics.errors) or
              (buffer.diagnostics.warnings ~= 0 and
              '  ' .. buffer.diagnostics.warnings)
              or ''
          end,
          fg = function(buffer)
            return
              (buffer.diagnostics.errors ~= 0 and errors_fg)
              or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
              or nil
          end,
          truncation = { priority = 1 },
        },
        close_or_unsaved = {
          text = function(buffer)
            return buffer.is_modified and '●' or ''
          end,
          fg = function(buffer)
            return buffer.is_focused and nbg or "#FFFFFF"
          end,
          delete_buffer_on_left_click = true,
          truncation = { priority = 1 },
        },
        left_half_circle = {
          text = "",
          fg = function(buffer)
            return buffer.is_focused and sbg or nbg
          end,
          bg = abg,
          truncation = {priority = 1},
        },
        right_half_circle = {
          text = "",
          fg = function(buffer)
            return buffer.is_focused and sbg or nbg
          end,
          bg = abg,
          truncation = {priority = 1},
        }
      }
      require("cokeline").setup({
        show_if_buffers_are_at_least = 2,
        buffers = {
          filter_valid = function(buffer)
            return buffer.type ~= 'terminal' 
          end,
          filter_visible = function(buffer) 
            return buffer.type ~= 'terminal' 
          end,
          new_buffers_position = 'next',
        },
        rendering = {
            max_buffer_width = 30,
          },
          default_hl = {
            fg = function(buffer)
              return
                buffer.is_focused
                and get_hex('Normal', 'fg')
                or get_hex('Comment', 'fg')
            end,
            bg = function(buffer)
              return
                  buffer.is_focused
                  and sbg
                  or nbg
            end,
          },
          sidebar = {
            filetype = 'neo-tree',
            components = {
              {
                text = function(buffer)
                  return " " .. buffer.filetype .. " "
                end,
                fg = vim.g.terminal_color_3,
                bg = function()
                  return get_hex("NvimTreeNormal", "bg")
                end,
                bold = true,
              },
            }
          },
          components = {
            components.separator,
            components.left_half_circle,
            components.space,
            components.devicon,
            components.space,
            components.index,
            components.unique_prefix,
            components.filename,
            components.diagnostics,
            components.two_spaces,
            components.close_or_unsaved,
            components.right_half_circle,
            components.separator,
          },
      })
    end
  },
  { "numToStr/Comment.nvim", lazy = false },

  -- Conform https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
      typescript = { "eslint_d" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      go = { "goimports", "gofmt" },
      ["*"] = { "codespell" },
      ["_"] = { "trim_whitespace" }
    },
    config = function()
     vim.api.nvim_create_user_command("Reformat", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(
          0, 
          args.line2 - 1,
          args.line2, 
          true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
      end
      require("conform").format({
        async = true, 
        lsp_fallback = true,
        range = range
      })
    end, 
    { range = true })
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "folke/neodev.nvim",
      "theHamsta/nvim-dap-virtual-text"
    },
    config = function()
      require('telescope').load_extension('dap')
      local dap, dapui = require("dap"), require("dapui")
      local dap_listen = dap.listeners
      dap_listen.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap_listen.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap_listen.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      require("neodev").setup({
        library = {
          plugins = { "nvim-dap-ui" },
          types = true 
        },
      })
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = true,
        only_first_definition = true,
        all_references = true,
        filter_references_pattern = "<module",
        virt_text_pos = "eol",
        all_frames = true,
        virt_lines = true,
        virt_text_win_col = nil
      })
    end
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        diff_binaries = true,
        enhanced_diff_hl = true,
        git_cmd = { "git" },
        use_icons = true,
        icons = {
           folder_closed = "",
          folder_open = ""
        },
        signs = {
          fold_closed = "",
          fold_open = "",
        },
        file_panel = {
          listing_style = "tree",
            tree_options = {
              flatten_dirs = true,
              folder_statuses = "only_folded",
            },
            win_config = {
              position = "left",
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
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["gf"] = actions.goto_file,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files
          },
          file_panel = {
            ["j"] = actions.next_entry,
            ["<down>"] = actions.next_entry,
            ["k"] = actions.prev_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["o"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["-"] = actions.toggle_stage_entry,
            ["S"] = actions.stage_all,
            ["U"] = actions.unstage_all,
            ["X"] = actions.restore_entry,
            ["R"] = actions.refresh_files,
            ["L"] = actions.open_commit_log,
            ["<c-b>"] = actions.scroll_view(-0.25),
            ["<c-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["gf"] = actions.goto_file,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["i"] = actions.listing_style,
            ["f"] = actions.toggle_flatten_dirs,
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files
          },
          file_history_panel = {
            ["g!"] = actions.options,
            ["<C-A-d>"] = actions.open_in_diffview,
            ["y"] = actions.copy_hash,
            ["L"] = actions.open_commit_log,
            ["zR"] = actions.open_all_folds,
            ["zM"] = actions.close_all_folds,
            ["j"] = actions.next_entry,
            ["<down>"] = actions.next_entry,
            ["k"] = actions.prev_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["o"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<c-b>"] = actions.scroll_view(-0.25),
            ["<c-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["gf"] = actions.goto_file,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files
          },
          option_panel = {
            ["<tab>"] = actions.select_entry,
            ["q"] = actions.close
          },
        }
      })
    end
  },
  "stevearc/dressing.nvim",
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
        -- LEFT
        -- vi-mode
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
        -- vi-symbol
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
        -- filename
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
        -- MID
        -- gitBranch
        components.active[2][1] = {
          provider = 'git_branch',
          hl = {
            fg = 'yellow',
            bg = colors.bg,
            style = 'bold'
          }
        }
        -- diffAdd
        components.active[2][2] = {
          provider = 'git_diff_added',
          hl = {
            fg = 'green',
            bg = colors.bg,
            style = 'bold'
          }
        }
        -- diffModfified
        components.active[2][3] = {
          provider = 'git_diff_changed',
          hl = {
            fg = 'orange',
            bg = colors.bg,
            style = 'bold'
          }
        }
        -- diffRemove
        components.active[2][4] = {
          provider = 'git_diff_removed',
          hl = {
            fg = 'red',
            bg = colors.bg,
            style = 'bold'
          },
        }
        -- diagnosticErrors
        components.active[2][5] = {
          provider = 'diagnostic_errors',
          enabled = function()
            return lsp.diagnostics_exist(
            vim.diagnostic.severity.ERROR) 
          end,
          hl = {
            fg = 'red',
            style = 'bold'
          }
        }
        -- diagnosticWarn
        components.active[2][6] = {
          provider = 'diagnostic_warnings',
          enabled = function()
            return lsp.diagnostics_exist(
            vim.diagnostic.severity.WARN)
          end,
          hl = {
            fg = 'yellow',
            style = 'bold'
          }
        }
        -- diagnosticHint
        components.active[2][7] = {
          provider = 'diagnostic_hints',
          enabled = function() 
            return lsp.diagnostics_exist(
            vim.diagnostic.severity.HINT) end,
          hl = {
            fg = 'cyan',
            style = 'bold'
          }
        }
        -- diagnosticInfo
        components.active[2][8] = {
          provider = 'diagnostic_info',
          enabled = function() 
            return lsp.diagnostics_exist(
            vim.diagnostic.severity.INFO)
          end,
          hl = {
            fg = 'skyblue',
            style = 'bold'
          }
        }
        -- RIGHT
        -- LspName
        components.active[3][1] = {
          provider = 'lsp_client_names',
          hl = {
            fg = 'yellow',
            bg = colors.bg,
            style = 'bold'
          },
          right_sep = ' '
        }
        -- fileIcon
        components.active[3][2] = {
          provider = function()
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon = require('nvim-web-devicons').get_icon(
            filename, extension)
            if icon == nil then
              icon = ''
            end
            return icon
          end,
          hl = function()
            local val = {}
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon, name = require('nvim-web-devicons').get_icon(
            filename, extension)
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
        -- fileType
        components.active[3][3] = {
          provider = 'file_type',
          hl = function()
            local val = {}
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon, name = require('nvim-web-devicons').get_icon(
            filename, extension)
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
        -- fileSize
        components.active[3][4] = {
          provider = 'file_size',
          enabled = function() 
            return vim.fn.getfsize(vim.fn.expand('%:t')) > 0
          end,
          hl = {
            fg = 'skyblue',
            bg = colors.bg,
            style = 'bold'
          },
          right_sep = ' '
        }
        -- fileFormat
        components.active[3][5] = {
          provider = function()
            return '' .. vim.bo.fileformat:upper() .. '' 
          end,
          hl = {
            fg = 'white',
            bg = colors.bg,
            style = 'bold'
          },
          right_sep = ' '
        }
        -- fileEncode
        components.active[3][6] = {
          provider = 'file_encoding',
          hl = {
            fg = 'white',
            bg = colors.bg,
            style = 'bold'
          },
          right_sep = ' '
        }
        -- WordCount
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
        -- lineInfo
        components.active[3][8] = {
          provider = 'position',
          hl = {
            fg = 'white',
            bg = colors.bg,
            style = 'bold'
          },
          right_sep = ' '
        }
        -- linePercent
        components.active[3][9] = {
          provider = 'line_percentage',
          hl = {
            fg = 'white',
            bg = colors.bg,
            style = 'bold'
          },
          right_sep = ' '
        }
        -- scrollBar
        components.active[3][10] = {
          provider = 'scroll_bar',
          hl = {
            fg = 'yellow',
            bg = colors.bg,
          },
        }
        -- INACTIVE
        -- fileType
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
    end
  },
  { 
    "lewis6991/gitsigns.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true
  },
  "ziontee113/icon-picker.nvim",
  "ellisonleao/glow.nvim",
  "lukas-reineke/indent-blankline.nvim",
  { "IndianBoy42/tree-sitter-just",
  dependencies =  "NoahTheDuke/vim-just" },
  "kdheepak/lazygit.nvim",
  { "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "folke/lsp-colors.nvim",
      "mfussenegger/nvim-lint"
    },
  },
  { "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
     version = "2.*"
  },
  "ixru/nvim-markdown",
  "jakewvincent/mkdnflow.nvim",
  { "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }
  },
  { "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim"
    },
  },
  { "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
  },
  { "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
      "rcasia/neotest-bash",
    }
  },
  {
    "rcarriga/nvim-notify",
   "HiPhish/rainbow-delimiters.nvim",
    "amitds1997/remote-nvim.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
  },
  { "rest-nvim/rest.nvim", dependencies = "nvim-lua/plenary.nvim" },
  "simrat39/rust-tools.nvim",
   "sidebar-nvim/sidebar.nvim",
   { 
     "gen740/SmoothCursor.nvim",
     "kylechui/nvim-surround",
     version = "*"
  },
  "nvim-telescope/telescope-media-files.nvim",
   "nvim-telescope/telescope-ui-select.nvim",
   {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { 
      "nvim-telescope/telescope.nvim", 
      "nvim-lua/plenary.nvim" 
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "olacin/telescope-gitmoji.nvim",
        "xiyaowong/telescope-emoji.nvim",
        "LinArcX/telescope-command-palette.nvim",
    }
  },
  "nvim-treesitter/nvim-treesitter",
  { "akinsho/toggleterm.nvim", version = "*" },
  { 
    "folke/todo-comments.nvim",
    dependecies = "nvim-lua/plenary.nvim"
  },
  "nvim-treesitter/nvim-tree-docs",  
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    }
  },
  { 
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons" 
  },
  "folke/twilight.nvim",
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig"
    }
  },
  { "kaarmu/typst.vim", ft = "typst" },
  "samjwill/nvim-unception",
  "adelarsq/vim-devicons-emoji",
  "jubnzv/virtual-types.nvim",
  "liuchengxu/vista.vim",
  "kyazdani42/nvim-web-devicons",
  "folke/which-key.nvim",
  "folke/zen-mode.nvim"
}


-- Setup package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(plugins)

--------------------------------------------
-- KEYMAPS
--------------------------------------------

local function keymap(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
keymap("i", "<C-E>", "<ESC>A")
keymap("i", "<C-A>", "<ESC>I")

-- Keybindings for telescope
keymap("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>")
keymap("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
keymap("n", "<leader>fb", "<CMD>Telescope file_browser<CR>")
keymap("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
keymap("n", "<leader>ht", "<CMD>Telescope colorscheme<CR>")

---------------------------------------------------
-- HIGHLIGHTS 
---------------------------------------------------

-- Highlight on yank

vim.api.nvim_create_autocmd("TextYankPost",
  {
    callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100
    }) 
  end 
})
