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

-- OPTIONS 
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

local plugins = {
  {
	'norcalli/nvim-colorizer.lua',
	config = true
},
{
	'ggandor/leap.nvim',
	config = function()
	require('leap').add_default_mappings()
	end
},
{
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true, -- or `opts = {}`
    },
  -- Neorg https://github.com/nvim-neorg/neorg
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "madskjeldgaard/neorg-figlet-module",
      "nvim-neorg/neorg-telescope"
    },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["external.integrations.figlet"] = {
	    config = {
	      font = "doom",
	      wrapInCodeTags = true
	    }
	  },
          ["core.integrations.telescope"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
      "joaomsa/telescope-orgmode.nvim"
    },
    event = 'VeryLazy',
    config = function()
    require("telescope").load_extension("orgmode")
      require('orgmode').setup_ts_grammar()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' },
        },
        ensure_installed = { 'org' },
      })
      require('orgmode').setup({
        org_agenda_files = '~/notes/**/*',
        org_default_notest_file = '~/nodes/notes.org'
      })
    end,
  },
  -- Colorschemes

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
          notify = true,
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

  {
    "ranjithshegde/orgWiki.nvim",
    config = function()
      require("orgWiki").setup({
         wiki_path = { "~/notes/documents/" },
         diary_path = "~/notes/diary/"
      })
    end
  },

  {
    "mrshmllow/orgmode-babel.nvim",
    dependencies = {
      "nvim-orgmode/orgmode",
      "nvim-treesitter/nvim-treesitter"
    },
    cmd = { "OrgExecute", "OrgTangle" },
    opts = {
      langs = { "python", "lua", ... },
      load_paths = {}
    }
  },

  'BartSte/nvim-khalorg',
  {
  'andreadev-it/orgmode-multi-key',
  config = function()
    require('orgmode-multi-key').setup()
  end
  },

  {
    'akinsho/org-bullets.nvim', config = true  },

  {
    "jubnzv/mdeval.nvim",
    config = function()
    end
  },

  {
    "danilshvalov/org-modern.nvim",
    config = function()
      require("orgmode").setup({
  ui = {
    menu = {
      handler = function(data)
        require("org-modern.menu"):new({
          window = {
            margin = { 1, 0, 1, 0 },
            padding = { 0, 1, 0, 1 },
            title_pos = "center",
            border = "single",
            zindex = 1000,
          },
          icons = {
            separator = "➜",
          },
            }):open(data)
            end,
          },
        },
      })
    end
  },

  -- Nvim tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
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
  -- Barbar
  {"romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function() 
      vim.g.barbar_auto_setup = true 
    end,
    opts = {
      animation = true,
      insert_at_start = true,
      auto_hide = false,
      tabpages = true,
      clickable = true,
      focus_on_close = "left",
      hide = {extensions = true, inactive = true},
      highlight_alternate = false,
      highlight_inactive_file_icons = false,
      highlight_visible = true,
      icons = {
        buffer_index = false,
      buffer_number = false,
      button = "",
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = {
          enabled = true,
          icon = "ﬀ"
        },
        [vim.diagnostic.severity.WARN] = {enabled = false},
        [vim.diagnostic.severity.INFO] = {enabled = false},
        [vim.diagnostic.severity.HINT] = {enabled = true},
      }, 
      gitsigns = {
        added = {enabled = true, icon = "+"},
        changed = {enabled = true, icon = "~"},
        deleted = {enabled = true, icon = "-"},
      },
      filetype = {
        custom_colors = false,
        enabled = true,
      },
      separator = {left = "▎", right = ""},
      separator_at_end = true,
      modified = {button = "●"},
      pinned = {button = "", filename = true},
      preset = "default",
      alternate = {filetype = {enabled = false}},
      current = {buffer_index = true},
      inactive = {button = "×"},
      visible = {modified = {buffer_number = false}},
      },
      insert_at_end = false,
      insert_at_start = false,
      maximum_padding = 1,
      minimum_padding = 1,
      maximum_length = 30,
      minimum_length = 0,
      semantic_letters = true,
      sidebar_filetypes = {
        NvimTree = true,
        undotree = {text = "undotree"},
        ["neo-tree"] = {event = "BufWipeout"},
        Outline = {event = "BufWinLeave", text = "symbols-outline"},
      },
      letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
      no_name_title = nil,
    },
    version = "^1.0.0",
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
          ["<C-p>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<C-n>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<CR>"] = cmp.mapping.confirm { select = false},
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          -- Tab mapping
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {"i", "s"}),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
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
          { name = "nvim_lsp" },
          { name = "luasnip", option = {use_show_condition=false}},
          { name = "path" },
          { name = "buffer" },
          { name = "spell" },
          { name = "orgmode" }
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
      require("telescope").load_extension("dap")
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
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          component_separators = { left = "", right = ""},
          section_separators = { left = "", right = ""},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_c = {"filename"},
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {"progress"},
          lualine_z = {"location"}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {"filename"},
          lualine_x = {"location"},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end
  }, 
  { 
    "lewis6991/gitsigns.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true
  },
  {
    "ziontee113/icon-picker.nvim",
    opts = { disable_legacy_commands = true }
  },
  {
    "arnamak/stay-centered.nvim",
    opts = {
      skip_filetypes = {
        "lua",
        "typescript",
        "python",
        "rust",
        "toml"
      },
    },
    config = true
  },
  {
    "ellisonleao/glow.nvim",
    lazy = false,
    config = true,
    cmd = "Glow"
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {},
    config = true
  },
  { 
    "IndianBoy42/tree-sitter-just",
    dependencies =  "NoahTheDuke/vim-just",
    config = true
  },
  "kdheepak/lazygit.nvim",
  { 
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "folke/lsp-colors.nvim",
      "mfussenegger/nvim-lint"
    },
    event = "VeryLazy",
    config = function()
      local nvim_lsp = require("lspconfig")
      local servers = {
        ansiblels = {},
        bashls = {},
        cssls = {},
        dockerls = {},
        docker_compose_language_service = {},
        html = {},
        jsonls = {},
        tsserver = {},
        jqls = {},
        lua_ls = {},
        intelephense = {},
        pyright = {},
        pylyzer = {},
        pylsp = {},
        ruff_lsp = {},
        sqlls = {},
        taplo = {},
        svelte = {},
        typst_lsp = {
          Typst = {
            exportPdf = "onSave",
          }
        }
      }
      require("mason").setup({
        ui = {
          border = "none",
          icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
          },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, { border = "rounded" }),
      }
      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
            bundle_path = (servers[server_name] or {}).bundle_path,
            root_dir = function()
                return vim.loop.cwd()
            end,
            handlers = handlers
          }
        end,
      })
      require("lint").linters_by_ft = {
        python = { "golangcilint", "flake8", "ruff" },
        typescript = { "eslint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end
      })
    end
  },
  { "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    version = "2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local sn = ls.snippet_node
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      local r = ls.restore_node
      local l = require("luasnip.extras").lambda
      local rep = require("luasnip.extras").rep
      local p = require("luasnip.extras").partial
      local m = require("luasnip.extras").match
      local n = require("luasnip.extras").nonempty
      local dl = require("luasnip.extras").dynamic_lambda
      local fmt = require("luasnip.extras.fmt").fmt
      local fmta = require("luasnip.extras.fmt").fmta
      local types = require("luasnip.util.types")
      local conds = require("luasnip.extras.expand_conditions")
      ls.config.set_config({
        history = true,
        update_events = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "choiceNode", "Comment" } },
            },
          },
        },
        ext_base_prio = 300,
        ext_prio_increase = 1,
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
        ft_func = function()
          return vim.split(vim.bo.filetype, ".", true)
        end,
      })
      local function copy(args)
        return args[1]
      end
      local rec_ls
        rec_ls = function()
          return sn(
            nil,
            c(1, {
              t(""),
              sn(nil, 
                { 
                  t({ "", "\t\\item " }), 
                  i(1), d(2, rec_ls, {}) 
                }
              ),
            })
          )
        end
        local function jdocsnip(args, _, old_state)
          local nodes = {
            t({ "/**", " * " }),
            i(1, "A short Description"),
            t({ "", "" }),
          }
          local param_nodes = {}
          if old_state then
            nodes[2] = i(1, old_state.descr:get_text())
          end
          param_nodes.descr = nodes[2]
          if string.find(args[2][1], ", ") then
            vim.list_extend(nodes, { t({ " * ", "" }) })
          end
          local insert = 2
          for 
            indx, arg in ipairs(
            vim.split(args[2][1], ", ", true)) do
            arg = vim.split(arg, " ", true)[2]
            if arg then
              local inode
              if old_state and old_state[arg] then
                inode = i(insert, 
                old_state["arg" .. arg]:get_text())
              else
                inode = i(insert)
              end
              vim.list_extend(
                nodes,
                { 
                  t({ " * @param " .. arg .. " " }),
                  inode,
                  t({ "", "" }) 
                }
              )
              param_nodes["arg" .. arg] = inode
              insert = insert + 1
            end
          end
          if args[1][1] ~= "void" then
            local inode
            if old_state and old_state.ret then
              inode = i(insert, old_state.ret:get_text())
            else
              inode = i(insert)
            end
            vim.list_extend(
              nodes,
              { 
                t({ " * ", " * @return " }),
                inode, 
                t({ "", "" }) 
              }
            )
            param_nodes.ret = inode
            insert = insert + 1
          end
          if vim.tbl_count(args[3]) ~= 1 then
            local exc = string.gsub(
            args[3][2], 
            " throws ",
            "")
            local ins
            if old_state and old_state.ex then
              ins = i(insert, old_state.ex:get_text())
            else
              ins = i(insert)
            end
              vim.list_extend(
              nodes,
                {
                  t({ " * ", " * @throws " .. exc .. " " }),
                  ins,
                  t({ "", "" }) 
                }
              )
              param_nodes.ex = ins
              insert = insert + 1
            end
            vim.list_extend(nodes, { t({ " */" }) })
            local snip = sn(nil, nodes)
            snip.old_state = param_nodes
            return snip
        end
        local function bash(_, _, command)
          local file = io.popen(command, "r")
          local res = {}
          for line in file:lines() do
            table.insert(res, line)
          end
          return res
        end
        local date_input = function(
          args, snip, old_state, fmt)
          local fmt = fmt or "%Y-%m-%d"
          return sn(nil, i(1, os.date(fmt)))
        end
        ls.add_snippets("all", {
          s("fn", {
            t("//Parameters: "),
            f(copy, 2),
            t({ "", "function " }),
            i(1),
            t("("),
            i(2, "int foo"),
            t({ ") {", "\t" }),
            i(0),
            t({ "", "}" }),
          }),
          s("class", {
            c(1, {
              t("public "),
              t("private "),
            }),
            t("class "),
            i(2),
            t(" "),
            c(3, {
              t("{"),
              sn(nil, {
                t("extends "),
                r(1, "other_class", i(1)),
                t(" {"),
              }),
              sn(nil, {
                t("implements "),
                r(1, "other_class"),
                t(" {"),
              }),
            }),
            t({ "", "\t" }),
            i(0),
            t({ "", "}" }),
          }),
          s(
            "fmt1",
            fmt("To {title} {} {}.", {
              i(2, "Name"),
              i(3, "Surname"),
              title = c(1, { t("Mr."), t("Ms.") }),
            })
          ),
          s(
            "fmt2",
            fmt(
              [[
            foo({1}, {3}) {{
              return {2} * {4}
            }}
            ]],
              {
                i(1, "x"),
                rep(1),
                i(2, "y"),
                rep(2),
                }
            )
          ),
          s(
            "fmt3",
            fmt("{} {a} {} {1} {}", {
              t("1"),
              t("2"),
              a = t("A"),
            })
          ),
          s(
            "fmt4", 
            fmt("foo() { return []; }", i(1, "x"), 
            { delimiters = "[]" })
          ),
          s("fmt5", fmta("foo() { return <>; }", i(1, "x"))),
          s(
            "fmt6",
            fmt(
            "use {} only",
            { t("this"), t("not this") },
            { strict = false }
            )
          ),
          s("novel", {
            t("It was a dark and stormy night on "),
            d(
              1,
              date_input, 
              {},
              { user_args = { "%A, %B %d of %Y" } }),
            t(" and the clocks were striking thirteen."),
          }),
          ls.parser.parse_snippet(
            "lspsyn",
            "Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"
          ),
          ls.parser.parse_snippet(
            { trig = "te", wordTrig = false },
            "${1:cond} ? ${2:true} : ${3:false}"
          ),
          s(
            "cond", {
              t("will only expand in c-style comments"),
            },
            {
              condition = function(
                line_to_cursor, matched_trigger, captures
                )
                    return line_to_cursor:match("%s*//")
                end,
            }
          ),
          s("cond2", {
            t("will only expand at the beginning of the line"),
          }, {
            condition = conds.line_begin,
          }),
          s(
            { trig = "a%d", regTrig = true },
            f(function(_, snip)
              return "Triggered with " .. snip.trigger .. "."
            end, {})
          ),
          s(
            { trig = "b(%d)", regTrig = true },
            f(function(_, snip)
              return "Captured Text: " .. snip.captures[1] .. "."
            end, {})
          ),
          s({ trig = "c(%d+)", regTrig = true }, {
            t("will only expand for even numbers"),
          }, {
            condition = function(
              line_to_cursor, matched_trigger, captures
              )
                return tonumber(captures[1]) % 2 == 0
            end,
          }),
          s("bash", f(bash, {}, { user_args = { "ls" } })),
          s("transform", {
            i(1, "initial text"),
            t({ "", "" }),
            l(l._1:match("[^i]*$")
            :gsub("i", "o")
            :gsub(" ", "_"):upper(), 1),
          }),
          s("transform2", {
            i(1, "initial text"),
            t("::"),
            i(2, "replacement for e"),
            t({ "", "" }),
            l(l._1:gsub("e", l._2), { 1, 2 }),
          }),
          s({ trig = "trafo(%d+)", regTrig = true }, {
            l(l.CAPTURE1:gsub("1", l.TM_FILENAME), {}),
          }),
          s("link_url", {
            t("<a href='"),
            f(function(_, snip)
              return snip.env.TM_SELECTED_TEXT[1] or {}
            end, {}),
            t("'>"),
            i(1),
            t("</a>"),
            i(0),
          }),
          s("repeat", { i(1, "text"), t({ "", "" }), rep(1) }),
          s("part", p(os.date, "%Y")),
          s("mat", {
            i(1, { "sample_text" }),
            t(": "),
            m(1, "%d", "contains a number", "no number :("),
          }),
          s("mat2", {
            i(1, { "sample_text" }),
            t(": "),
            m(1, "[abc][abc][abc]"),
          }),
          s("mat3", {
            i(1, { "sample_text" }),
            t(": "),
            m(
              1,
              l._1:gsub("[123]", ""):match("%d"),
              "contains a number that isn't 1, 2 or 3!"
            ),
          }),
          s("mat4", {
            i(1, { "sample_text" }),
            t(": "),
            m(1, function(args)
              return (#args[1][1] % 2 == 0 and args[1]) or nil
            end),
          }),
          s("nempty", {
            i(1, "sample_text"),
            n(1, "i(1) is not empty!"),
          }),
          s("dl1", {
            i(1, "sample_text"),
            t({ ":", "" }),
            dl(2, l._1, 1),
          }),
          s("dl2", {
            i(1, "sample_text"),
            i(2, "sample_text_2"),
            t({ "", "" }),
            dl(3, l._1:gsub("\n", " linebreak ") .. l._2, { 1, 2 }),
          }),
        }, {
          key = "all",
        })
        ls.add_snippets("java", {
          s("fn", {
            d(6, jdocsnip, { 2, 4, 5 }),
            t({ "", "" }),
            c(1, {
              t("public "),
              t("private "),
            }),
            c(2, {
              t("void"),
              t("String"),
              t("char"),
              t("int"),
              t("double"),
              t("boolean"),
              i(nil, ""),
            }),
            t(" "),
            i(3, "myFunc"),
            t("("),
            i(4),
            t(")"),
            c(5, {
              t(""),
              sn(nil, {
                t({ "", " throws " }),
                i(1),
              }),
            }),
            t({ " {", "\t" }),
            i(0),
            t({ "", "}" }),
          }),
        }, {
          key = "java",
        })
        ls.add_snippets("tex", {
          s("ls", {
            t({ "\\begin{itemize}", "\t\\item " }),
            i(1),
            d(2, rec_ls, {}),
            t({ "", "\\end{itemize}" }),
          }),
        }, {
          key = "tex",
        })
        ls.add_snippets("all", {
          s("autotrigger", {
            t("autosnippet"),
          }),
        }, {
          type = "autosnippets",
          key = "all_auto",
        })
        ls.filetype_extend("lua", { "c" })
        ls.filetype_set("cpp", { "c" })
        require("luasnip/loaders/from_vscode").lazy_load()
        require("luasnip/loaders/from_vscode").lazy_load(
          { paths = { "./snippets" } })
        ls.filetype_extend("all", { "_" })
        require("luasnip.loaders.from_snipmate").load(
          { include = { "c" } })
        require("luasnip.loaders.from_snipmate").load({
          path = { "./my-snippets" } })
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_lua").load(
          { include = { "c" } })
        require("luasnip.loaders.from_lua").lazy_load(
          { include = { "all", "cpp" } })
    end
  },
  "ixru/nvim-markdown",
  "jakewvincent/mkdnflow.nvim",
  { 
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      enabled = true,
      snippet_engine = "luasnip",
      languages = {
        rust = {
          template = {
            annotation_convention = "rustdoc",
          }
        },
        python = {
          template = {
            annotation_convention = "numpydoc",
          }
        },
        javascript = {
          template = {
            annotation_convention = "tsdoc",
          }
        },
        typescript = {
          template = {
            annotation_convention = "tsdoc",
          }
        }
      }
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
    opts = {
      notify = {
        view = "mini"
      },
      messages = {
        view = "mini"
      },
      errors = {
        view = "mini"
      }
    }
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
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
      "zidhuss/neotest-minitest",
      "olimorris/neotest-rspec",
      "sidlatau/neotest-dart",
      "olimorris/neotest-phpunit",
      "jfpedroza/neotest-elixir",
      "Issafalcon/neotest-dotnet",
      "stevanmilic/neotest-scala",
      "mrcjkb/neotest-haskell",
      "markemmons/neotest-deno",
      "rcasia/neotest-java",
      "lawrence-laz/neotest-zig",
      "alfaix/neotest-gtest"
    },
    opts = {},
    config = function()
      require("neotest").setup({
        log_level = vim.log.levels.WARN,
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "unittest",
            python = ".venv/bin/python",
          }),
          require("neotest-rust")({
            args = { "--no-capture" },
            dap_adapter = "lldb",
          }),
          require("neotest-bash"),
          require("neotest-go"),
          require("neotest-jest"),
          require("neotest-vitest"),
          require("neotest-playwright").adapter({
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            }
          }),
          require("neotest-rspec"),
          require("neotest-minitest"),
          require("neotest-dart")({
            command = "flutter",
            use_lsp = true,
            custom_test_method_names = {},
          }),
          require("neotest-phpunit"),
          require("neotest-elixir"),
          require("neotest-dotnet")({
            dap = { justMyCode = false },
            dotnet_additional_args = { "--verbosity detailed" }
          }),
          require("neotest-scala")({
            args = { "--no-color" },
            runner = "bloop",
            franerwork = "utest"
          }),
          require("neotest-haskell")({
            build_tools = { "stack", "cabal" },
            frameworks = { "tasty", "hspec", "sydtest" }
          }),
          require("neotest-deno"),
          require("neotest-java")({
            ignore_wrapper = false
          }),
          require("neotest-zig"),
        },
        discovery = {
          enabled = true,
          concurrent = 0,
          filter_dir = nil,
        },
        running = {
          concurrent = true,
        },
        consumers = {},
        icons = {
          running_animated = { 
            "/", "|", "\\", "-", "/", "|", "\\", "-"
          },
            passed = "",
            running = "",
            failed = "",
            skipped = "",
            unknown = "",
            non_collapsible = "─",
            collapsed = "─",
            expanded = "╮",
            child_prefix = "├",
            final_child_prefix = "╰",
            child_indent = "│",
            final_child_indent = " ",
            watching = "",
          },
          highlights = {
            passed = "NeotestPassed",
            running = "NeotestRunning",
            failed = "NeotestFailed",
            skipped = "NeotestSkipped",
            test = "NeotestTest",
            namespace = "NeotestNamespace",
            focused = "NeotestFocused",
            file = "NeotestFile",
            dir = "NeotestDir",
            border = "NeotestBorder",
            indent = "NeotestIndent",
            expand_marker = "NeotestExpandMarker",
            adapter_name = "NeotestAdapterName",
            select_win = "NeotestWinSelect",
            marked = "NeotestMarked",
            target = "NeotestTarget",
            unknown = "NeotestUnknown",
            watching = "NeotestWatching",
          },
          floating = {
            border = "rounded",
            max_height = 0.6,
            max_width = 0.6,
            options = {},
          },
          default_strategy = "integrated",
          strategies = {
            integrated = {
              width = 120,
              height = 40,
            },
          },
          summary = {
            enabled = true,
            animated = true,
            follow = true,
            expand_errors = true,
            open = "botright vsplit | vertical resize 50",
            mappings = {
              expand = { "<CR>", "<2-LeftMouse>" },
              expand_all = "e",
              output = "o",
              short = "O",
              attach = "a",
              jumpto = "i",
              stop = "u",
              run = "r",
              debug = "d",
              mark = "m",
              run_marked = "R",
              debug_marked = "D",
              clear_marked = "M",
              target = "t",
              clear_target = "T",
              next_failed = "J",
              prev_failed = "K",
              watch = "w",
            },
          },
          benchmark = {
            enabled = true,
          },
          output = {
            enabled = true,
            open_on_run = "short",
          },
          output_panel = {
            enabled = true,
            open = "botright split | resize 15",
          },
          diagnostic = {
            enabled = true,
            severity = vim.diagnostic.severity.ERROR,
          },
          status = {
            enabled = true,
            virtual_text = false,
            signs = true,
          },
          run = {
            enabled = true,
          },
          jump = {
            enabled = true,
          },
          quickfix = {
            enabled = true,
            open = false,
          },
          state = {
            enabled = true,
          },
          watch = {
            enabled = true,
          },
          projects = {},
        })
    end
  },
  -- Notify
  {
     "rcarriga/nvim-notify",
    opts = {
       background_colour = "#000000"
    }
  },
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup")({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          commonlisp = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          latex = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end
  },
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    config = true
  },
  -- Rest
  { 
    "rest-nvim/rest.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = false,
    config = true,
    opts = {
      result_split_horizontal = false,
      result_split_in_place = false,
      stay_in_current_window_after_split = false,
      skip_ssl_verification = false,
      encode_url = true,
      highlight = {
          enabled = true,
          timeout = 150,
      }, 
      result = {
        show_url = true,
        show_curl_command = true,
        show_http_info = true,
        show_headers = true,
        show_statistics = false,
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({ 
              "tidy",
              "-i",
              "-q", 
              "-"
            },
            body)
          end
        },
      },
      jump_to_request = false,
      env_file = ".env",
      custom_dynamic_variables = {},
      yank_dry_run = true,
      search_back = true,
    }
  },
  {
    "sidebar-nvim/sidebar.nvim",
    opts = {
      open = false
    }
  },
   
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = true,
    opts = {
      type = "exp",
      fancy = {
        enable = true
      }
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    config = function()
      require"telescope".setup {
        extensions = {
          media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg"
          }
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").setup {
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown()
            }
          }
        }
        require("telescope").load_extension("ui-select")
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { 
      "nvim-telescope/telescope.nvim", 
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end
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
      "LinArcX/telescope-command-palette.nvim"
    },
    config = function()
      local lga_actions = require("telescope-live-grep-args.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = { ["<C-h>"] = "which_key" }
          }
        },
        pickers = {},
        extensions = {
          workspaces = { keep_insert = true },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({
                  postfix = " --iglob " }
                ),
              },
            },
          },
          gitmoji = {
            action = function()
              entry = {
                display = "🐛 Fix a bug.",
                index = 4,
                ordinal = "Fix a bug.",
                value = {
                  description = "Fix a bug.",
                  text = ":bug:",
                  value = "🐛"
                }
              }
              local emoji = entry.value.value
              vim.ui.input(
                { prompt = "Enter commit message: " .. emoji .. " "},
                function(msg)
                  if not msg then return end
                  local emoji_text = entry.value.text
                  vim.cmg(
                  ":G commit -m'" .. emoji_text .. " " .. msg .. "'"
                  )
                end)
            end
          },
          command_palette = {
            { "File",
              { "entire selection (C-a)", ":call feedkeys('GVgg')" },
              { "save current file (C-s)", ":w" },
              { "save all files (C-A-s)", ":wa" },
              { "quit (C-q)", ":qa" },
              { "file browser (C-i)", ":Telescope file_browser", 1 },
              { "search word (A-w)", ":Telescope live_grep", 1 },
              { "git files (A-f)", ":Telescope git_files", 1 },
              { "files (C-f)", ":Telescope find_files", 1 },
            },
            { "Help",
              { "tips", ":help tips" },
              { "cheatsheet", ":help index" },
              { "tutorial", ":help tutor" },
              { "summary", ":help summary" },
              { "quick reference", ":help quickref" },
              { "search help(F1)", ":Telescope help_tags", 1 },
            },
            { "Code",
              { "Preview markdown", ":Glow" },
              { "Reformat code", ":Reformat" }
            },
            { "Vim",
              { "reload vimrc", ":source $MYVIMRC" },
              { "check health", ":checkhealth" },
              { "jumps (Alt-j)",":Telescope jumplist" },
              { "commands", ":Telescope commands" },
              { "command history", ":Telescope command_history" },
              { "registers (A-e)", ":Telescope registers" },
              { "colorshceme", ":Telescope colorscheme", 1 },
              { "vim options", ":Telescope vim_options" },
              { "keymaps", ":Telescope keymaps" },
              { "buffers", ":Telescope buffers" },
              { "search history (C-h)", ":Telescope search_history" },
              { "paste mode", ":set paste!" },
              { "cursor line", ":set cursorline!" },
              { "cursor column", ":set cursorcolumn!" },
              { "spell checker", ":set spell!" },
              { "relative number", ":set relativenumber!" },
              { "search highlighting (F12)", ":set hlsearch!" },
            }
          }
        }
      })
      require("telescope").load_extension("gitmoji")
      require("telescope").load_extension("emoji")
      require("telescope").load_extension("command_palette")
    end
  },
  -- Hop
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end
  },
  -- Neovim treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    opts = {
      ensure_installed = {
        "vim",
        "c",
        "query",
        "vimdoc",
        "ada",
        "agda",
        "angular",
        "apex",
        "astro",
        "bass",
        "bibtex",
        "bicep",
        "c_sharp",
        "capnp",
        "clojure",
        "cmake",
        "comment",
        "csv",
        "css",
        "cpp",
        "dart",
        "diff",
        "dot",
        "dockerfile",
        "doxygen",
        "elixir",
        "erlang",
        "fennel",
        "fish",
        "fortran",
        "git_config",
        "git_rebase",
        "gitcommit",
        "go",
        "gomod",
        "gosum",
        "gpg",
        "graphql",
        "groovy",
        "haskell",
        "haskell_persistent",
        "hcl",
        "hjson",
        "html",
        "http",
        "hurl",
        "java",
        "json",
        "jsdoc",
        "julia",
        "kotlin",
        "luau",
        "luadoc",
        "make",
        "matlab",
        "meson",
        "nim",
        "nix",
        "org",
        "pascal",
        "perl",
        "phpdoc",
        "prisma",
        "psv",
        "pug",
        "ql",
        "robot",
        "ruby",
        "scala",
        "scss",
        "solidity",
        "svelte",
        "swift",
        "sxhkdrc",
        "templ",
        "terraform",
        "toml",
        "ninja",
        "regex",
        "lua",
        "bash",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "sql",
        "php",
        "javascript",
        "http",
        "json",
        "latex",
        "commonlisp",
        "tsv",
        "tsx",
        "twig",
        "typescript",
        "typoscript",
        "udev",
        "usd",
        "vala",
        "vue",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
        "zathurarc"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 
          "php",
          "markdown",
          "rust",
          "python"
        },
      },
      rainbow = {
        enable = true,
        extended_mode = true,
      },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = '<CR>',
          scope_incremental = '<CR>',
          node_incremental = '<TAB>',
          node_decremental = '<S-TAB>',
        }
      },
      indent = {
        enable = true,
        disable = { "python" },
      },
      tree_docs = {
        enable = true,
      }
    }
  },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  { 
    "folke/todo-comments.nvim",
    dependecies = "nvim-lua/plenary.nvim",
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { 
          icon = " ",
          color = "warning",
          alt = { "WARNING", "XXX" } 
        },
        PERF = {
          icon = " ",
          alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
        },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { 
          icon = "⏲ ",
          color = "test",
          alt = { "TESTING", "PASSED", "FAILED" }
        },
      },
      merge_keywords = true,
      highlight = {
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
      colors = {
       error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
       warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
       info = { "DiagnosticInfo", "#2563EB" },
       hint = { "DiagnosticHint", "#10B981" },
       default = { "Identifier", "#7C3AED" },
       test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    }
  },
  "nvim-treesitter/nvim-tree-docs",  
  { 
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    opts = {
      position = "bottom",
      height = 10,
      width = 50,
      icons = true,
      mode = "workspace_diagnostics",
      fold_open = "",
      fold_closed = "",
      group = true,
      padding = true,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "<tab>" },
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump_close = { "o" },
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j"
      },
      indent_lines = true,
      auto_open = false,
      auto_close = false,
      auto_preview = true,
      auto_fold = false,
      auto_jump = { "lsp_definitions" },
      signs = {
        error = "☢️",
        warn = "⚠️",
        hint = "🔍",
        info = "ℹ️",
        other = "🤷"
      },
      use_diagnostic_signs = false
    }
  },
  "folke/twilight.nvim",
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig"
    },
    opts = {
      tsserver_locale = "es",
    },
  },
  { "kaarmu/typst.vim", ft = "typst", lazy = false },
  "samjwill/nvim-unception",
  "adelarsq/vim-devicons-emoji",
  "jubnzv/virtual-types.nvim",
  { 
    "liuchengxu/vista.vim",
    config = function()
      local g = vim.g
      local cmd = vim.cmd
      g.vista_icon_indent = '["╰─▸ ", "├─▸ "]'
      g.vista_default_executive = 'ctags'
      cmd[[let g:vista#renderer#enable_icon = 1]]
    end
  },
  "kyazdani42/nvim-web-devicons",
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local which_key = require("which-key")

      local setup = {
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        operators = { gc = "Comments" },
        key_labels = {},
        icons = {
          breadcrumb = "»",
            separator = "➜",
            group = "+",
        },
        popup_mappings = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        window = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 0, 0, 0, 0 },
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 20 },
          width = { min = 20, max = 50 },
          spacing = 1,
          align = "center",
        },
        ignore_missing = true,
        hidden = {
          "<silent>",
          "<cmd>",
          "<Cmd>",
          "<CR>",
          "call",
          "lua",
          "^:",
          "^ " 
        },
        show_help = true,
          triggers_blacklist = {
            i = { "j", "k" },
            v = { "j", "k" },
        },
      }
      local opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,
      }
      local m_opts = {
          mode = "n",
          prefix = "m",
          buffer = nil,
            silent = true,
            noremap = true,
            nowait = true,
      }
      -- TODO Mappings
               local mappings = {
            ["0"] = { "<Plug>(cokeline-focus-0)", "Focus 0"},
            ["1"] = { "<Plug>(cokeline-focus-1)", "Focus 1"},
            ["2"] = { "<Plug>(cokeline-focus-2)", "Focus 2"},
            ["3"] = { "<Plug>(cokeline-focus-3)", "Focus 3"},
            ["4"] = { "<Plug>(cokeline-focus-4)", "Focus 4"},
            ["5"] = { "<Plug>(cokeline-focus-5)", "Focus 5"},
            ["6"] = { "<Plug>(cokeline-focus-6)", "Focus 6"},
            ["7"] = { "<Plug>(cokeline-focus-7)", "Focus 7"},
            ["8"] = { "<Plug>(cokeline-focus-8)", "Focus 8"},
            ["9"] = { "<Plug>(cokeline-focus-9)", "Focus 9"},
            B = {
                name = "Bookmarks",
                a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
                c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
                t = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
                m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
                n = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon Toggle" },
                l = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
                j = { "<cmd>silent BookmarkNext<cr>", "Next" },
                s = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
                k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
                S = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
                x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
            },
            c = { "<cmd>nohl<CR>", "Clear search higlighting" },
            d = {
                name = "Debug",
                b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
                c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
                i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
                o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
                O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
                r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
                l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
                x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
                t = {
                    name = "Telescope",
                    c = {"<cmd>lua require'telescope'.extensions.dap.commands{}<CR>", "Telescope"},
                    o = {"<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>", "Telescope"},
                    b = {"<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>", "Telescope"},
                    v = {"<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", "Telescope"},
                    f = {"<cmd>lua require'telescope'.extensions.dap.frames{}<CR>", "Telescope"},
                },
                u = {
                    name = "dap-ui",
                    s = { "<cmd>lua require'dapui'.setup()<cr>", "Setup" },
                    o = { "<cmd>lua require'dapui'.open()<cr>", "Open" },
                    c = { "<cmd>lua require'dapui'.close()<cr>", "Close" },
                    t = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle" },
                },
            },
            D = {
                name = "Documentation",
                d = {"<cmd>lua require'neogen'.generate()<cr>", "Generate  docu"},
            },
            f = {
                name = "Find/Focus",
                b = { "<cmd>Telescope buffers<cr>", "Find in buffers" },
                c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
                d = { "<cmd>Telescope gitmoji<cr>", "Gitmoji" },
                e = { "<cmd>Telescope emoji<cr>", "Emojis" },
                f = { "<cmd>Telescope find_files<cr>", "Find File" },
                g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
                h = { "<cmd>Telescope help_tags<cr>", "Help" },
                i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
                k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
                l = { "<cmd>Telescope resume<cr>", "Last Search" },
                n = { "<Plug>(cokeline-switch-next)", "Focus next"},
                o = { "<cmd>Telescope file_browser<cr>", "Commands" },
                p = { "<Plug>(cokeline-switch-prev)", "Focus preview"},
                r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
                s = { "<cmd>Telescope grep_string theme=ivy<cr>", "Find String" },
                t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
                y = { "<cmd>Telescope symbols<cr>", "Symbols" },
                C = { "<cmd>Telescope commands<cr>", "Commands" },
                M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
                R = { "<cmd>Telescope registers<cr>", "Registers" },
                -- Focus
            },
            g = {
                name = "Git",
                g = { "<cmd>LazyGit<cr>", "Lazygit" },
                j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
                k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
                l = { "<cmd>GitBlameToggle<cr>", "Blame" },
                m = { "<cmd>Telescope gitmoji<cr>", "Git emoji" },
                p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
                r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
                R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
                s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
                u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk", },
                o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
                b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
                d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff", },
                i = { "<cmd>SidebarNvimToggle<cr>", "Toggle sidebar", },

                G = {
                    name = "Gist",
                    a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
                    d = { "<cmd>Gist -d<cr>", "Delete" },
                    f = { "<cmd>Gist -f<cr>", "Fork" },
                    g = { "<cmd>Gist -b<cr>", "Create" },
                    l = { "<cmd>Gist -l<cr>", "List" },
                    p = { "<cmd>Gist -b -p<cr>", "Create Private" },
                },
            },
            l = {
                name = "LSP",
                a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
                w = {
                    "<cmd>Telescope lsp_workspace_diagnostics<cr>",
                    "Workspace Diagnostics",
                },
                f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
                F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
                d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition"},
                G = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration"},
                i = { "<cmd>LspInfo<cr>", "Info" },
                I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
                h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
                j = {
                    "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
                    "Next Diagnostic",
                },
                k = {
                    "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
                    "Prev Diagnostic",
                },
                K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
                l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
                o = { "<cmd>SymbolsOutline<cr>", "Outline" },
                q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
                r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
                R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
                s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
                S = {
                    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                    "Workspace Symbols",
                },
                t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
                u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
                x = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
            },
            o = {
                name = "Options",
                w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
                r = { '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative" },
                l = { '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline" },
                s = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
                t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
            },
            p = {
                name = "Lazy",
                c = { "<cmd>Lazy check<cr>", "Check" },
                C = { "<cmd>Lazy clean<cr>", "Clean" },
                i = { "<cmd>Lazy install<cr>", "Install" },
                s = { "<cmd>Lazy sync<cr>", "Sync" },
                u = { "<cmd>Lazy update<cr>", "Update" },
                r = { "<cmd>Lazy restore<cr>", "Restore" },
                l = { "<cmd>Lazy<cr>", "Lazy" },
            },
            r = {
                name = "Rest",
                r = { "<Plug>RestNvim", "Run rest" },
                p = { "<Plug>RestNvimPreview", "Run rest preview" },
                l = { "<Plug>RestNvimLast", "Run rest last" },
            },
            s = {
                name = "Telescope",
                c = { "<cmd>Telescope eomoji<cr>", "Close" },
                f = { "<cmd>%SnipRun<cr>", "Run File" },
                i = { "<cmd>SnipInfo<cr>", "Info" },
                m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
                r = { "<cmd>SnipReset<cr>", "Reset" },
                t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
                x = { "<cmd>SnipTerminate<cr>", "Terminate" },
            },
            S = { "<cmd>w<CR>", "Fast saving"},
            t = {
                name = "Terminal",
                ["1"] = { ":1ToggleTerm<cr>", "1" },
                ["2"] = { ":2ToggleTerm<cr>", "2" },
                ["3"] = { ":3ToggleTerm<cr>", "3" },
                ["4"] = { ":4ToggleTerm<cr>", "4" },
                f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
                h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
                j = { "<cmd>TermExec cmd='gjs %'<cr>", "Execute JavaScript" },
                p = { "<cmd>TermExec cmd='python %'<cr>", "Execute Python" },
                t = { "<cmd> ToggleTerm<cr>", "Open terminal"},
                v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
            },
            T = {
                name = "Treesitter",
                h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
                p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
                r = { "<cmd>TSToggle rainbow<cr>", "Rainbow" },
            },
            u = {
                name = "TodoComments",
                ["t"] = { "<cmd>TodoTelescope<CR>", "Show Comments" },
                ["q"] = { "<cmd>TodoQuickFix<CR>", "Quick Fix" },
                ["l"] = { "<cmd>TodoLocList<CR>", "List Comments" },
            },
            v = {
                name = "Vista",
                o = { "<cmd>:Vista!!<cr>", "Open Tag viewer" },
            },
            w = {
                name = "Window",
                v = { "<C-w>v", "Vertical Split" },
                h = { "<C-w>s", "Horizontal Split" },
                e = { "<C-w>=", "Make Splits Equal" },
                q = { "close<CR>", "Close Split" },
                m = { "MaximizerToggle<CR>", "Toggle Maximizer" },
            },
            x = {
                name = "Trouble",
                x = {"<cmd>Trouble<cr>", "Open Trouble window"},
                w = {"<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics"},
                d = {"<cmd>Trouble document_diagnostics<cr>", "Documents"},
                l = {"<cmd>Trouble loclist<cr>", "List"},
                q = {"<cmd>Trouble quickfix<cr>", "QuickFix"},

            },
            z = {
                name = "Zettelkasten",
                b = {"<cmd>ZkBacklinks<cr>", "Backlinks"},
                h = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
                l = {"<cmd>ZkLinks<cr>", "Links"},
                n = {"<cmd>ZkNew { title = vim.fn.input('Título: ') }<cr>", "Nueva nota"},
                o = {"<cmd>ZkNotes<cr>", "Abrir notas"},
                t = {"<cmd>ZkTags<cr>", "Abrir tags"},

            }
        }

             local topts = {
            mode = "t", -- TERMINAL mode
            prefix = "",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local tmappings = {
            ["<C-t>"] = {
                ["1"] = {"<cmd>1ToggleTerm<cr>", "ToggleTerm"},
                ["2"] = {"<cmd>2ToggleTerm<cr>", "ToggleTerm"},
                ["3"] = {"<cmd>3ToggleTerm<cr>", "ToggleTerm"},
                ["4"] = {"<cmd>4ToggleTerm<cr>", "ToggleTerm"},
            },
            ["<esc>"] = {"<cmd>ToggleTerm<cr>", "ToggleTerm"},
            ["<C-h>"] = {"<cmd>wincmd h<cr>", "ToggleTerm"},
            ["<C-j>"] = {"<cmd>wincmd j<cr>", "ToggleTerm"},
            ["<C-k>"] = {"<cmd>wincmd k<cr>", "ToggleTerm"},
            ["<C-l>"] = {"<cmd>wincmd l<cr>", "ToggleTerm"},
            --["<C-t>"] = {"<cmd>ToggleTerm<cr>", "ToggleTerm"},
            ["<C-w>"] = {
                h = { "<C-\\><C-n><C-w>h", "Terminal" },
                j = { "<C-\\><C-n><C-w>j", "Terminal" },
                k = { "<C-\\><C-n><C-w>k", "Terminal" },
                l = { "<C-\\><C-n><C-w>l", "Terminal" },
                ["<C-w>"] = { "<C-\\><C-n><C-w><C-w>", "Terminal" },
            }
        }

        local vopts = {
            mode = "v", -- VISUAL mode
            prefix = "<leader>",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local vmappings = {
            ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
            s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
            z = {
                name = "Zettelkasten",
                a = {":'<,'>lua vim.lsp.buf.range_code_action()<cr>", "Acciones"},
                f = {"<cmd>ZkMatch<cr>", "Abrir por selección"},

            }
        }

        local iopts = {
            mode = "i", -- INSERT mode
            prefix = "",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local imappings = {
            ["<C-h>"] = { "<left>", "Movements"},
            ["<C-j>"] = { "<down>", "Movements"},
            ["<C-k>"] = { "<up>", "Movements"},
            ["<C-l>"] = { "<right>", "Movements"},
        }


        local nopts = {
            mode = "n", -- NORMAL mode
            prefix = "",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }

        local nmappings = {
            ["<C-h>"] = { "<C-w>h", "Movements"},
            ["<C-j>"] = { "<C-w>j", "Movements"},
            ["<C-k>"] = { "<C-w>k", "Movements"},
            ["<C-l>"] = { "<C-w>l", "Movements"},
            ["<C-g>"] = { "<cmd> LazyGit<cr>", "Open LazyGit"},
            ["<C-n>"] = { "<cmd> Neotree toggle<cr>", "Toggle Neotree"},
            ["<C-7>"] = { "<cmd> Telescope command_palette<cr>", "Paleta de comandos"},
            ["<C-q>"] = { "<cmd> Vista!!<cr>", "Vista"},
            ["<C-s>"] = { "<cmd> SidebarNvimToggle<cr>", "Vista"},
            ["<C-t>"] = { "<cmd>ToggleTerm<cr>", "Toggle terminal"},
            ["<bs>"] = { ":edit #<cr>", "Hacia atrás"},
            g = {
                name = "LSP",
                d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition"},
                h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover"},
                i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation"},
                s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature"},
                D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration"},
            },
        }

                which_key.setup(setup)
        which_key.register(mappings, opts)
        which_key.register(vmappings, vopts)
        which_key.register(tmappings, topts)
        which_key.register(imappings, iopts)
        which_key.register(nmappings, nopts)
    end
  },
  "folke/zen-mode.nvim",
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

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Barbar
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>")
map("n", "<A-.>", "<Cmd>BufferNext<CR>")
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>")
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>")
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>")
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>")
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>")
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>")
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>")
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>")
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>")
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>")
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>")
map("n", "<A-0>", "<Cmd>BufferLast<CR>")
map("n", "<A-p>", "<Cmd>BufferPin<CR>")
map("n", "<A-c>", "<Cmd>BufferClose<CR>")
map("n", "<C-p>", "<Cmd>BufferPick<CR>")
map("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>")
map("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>")
map("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>")
map("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>")

-- Telescope
map("n", "<leader>fb", "<cmdTelescope buffers<cr>")
map("n", "<leader>fc", "<cmd>telescope commands<cr>")
map("n", "<leader>fd", "<cmd>telescope diagnostics<cr>")
map("n", "<leader>ff", "<cmd>telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>telescope live_grep<cr>")
map("n", "<leader>fgb", "<cmd>telescope git_branches<cr>")
map("n", "<leader>fgc", "<cmd>telescope git_commits<cr>")
map("n", "<leader>fgs", "<cmd>telescope git_status<cr>")
map("n", "<leader>fh", "<cmd>telescope help_tags<cr>")

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
  {
    callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100
    }) 
  end 
})
