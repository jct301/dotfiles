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


--------------------------------------------
-- PLUGINS
--------------------------------------------

-- Plugins list
local plugins = {
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
            indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
            arg = vim.split(arg, " ", true)[2]
            if arg then
              local inode
              if old_state and old_state[arg] then
                inode = i(insert, old_state["arg" .. arg]:get_text())
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
            local exc = string.gsub(args[3][2], " throws ", "")
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
        local date_input = function(args, snip, old_state, fmt)
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
            t('<a href="'),
            f(function(_, snip)
              return snip.env.TM_SELECTED_TEXT[1] or {}
            end, {}),
            t('">'),
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

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Keybindings for telescope
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>")
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
map("n", "<leader>fb", "<CMD>Telescope file_browser<CR>")
map("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>ht", "<CMD>Telescope colorscheme<CR>")

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
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>")
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>")
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>")
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>")

---------------------------------------------------
-- HIGHLIGHTS 
---------------------------------------------------

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
