return {
  -- Autoclose
  -- https://github.com/m4xshen/autoclose.nvim
  -- Plugin that auto pairs & closes brackets written in 100% lua.
  { 
    'm4xshen/autoclose.nvim',
    event = 'VeryLazy',
    opts = { enabled = true} 
  },

  -- Autosave
  -- 
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
          utils.not_in(fn.getbufvar(buf,
          '&filetype'), 
          {}) then
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
    opts = {
      extra_keymaps = false,
      extended_keymaps = true,
      override_keymaps = false,
      always_scroll = true,
      default_keymaps = true,
      centered = true,
      disable = false,
      max_length = 1000,
      scroll_limit = -1,
      default_delay = 7,
      hide_cursor = false,
      horizontal_scroll = true
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
  
  -- Cokeline
  {
    'willothy/nvim-cokeline',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'stevearc/resession.nvim'
    },
    config = true 
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
      vim.api.nvim_create_user_command('Reformat',
      function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(
          0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        require('conform').format({ 
          async = true,
          lsp_fallback = true,
          range = range })
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
    'freddiehaddad/feline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'gitsigns.nvim',
      'nvim-web-devicons'
    },
    config = function()
      require('feline').setup()
      require('feline').winbar.setup()
      require('feline').statuscolumn.setup()
    end,
  },
 
  -- Gitsigns
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
  },

  -- Glow
  {
    'ellisonleao/glow.nvim',
    lazy = false,
    config = true,
    cmd = 'Glow'
  },

  -- Icon picker
  {
    'ziontee113/icon-picker.nvim',
    opts = {
      disable_legacy_commands = true
    }
  },

  -- Indent blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    main = 'ibl',
    opts = {},
  },

  -- Just
  {
    'IndianBoy42/tree-sitter-just',
    dependencies = {
      'NoahTheDuke/vim-just',
    },
  },

  -- Lazygit
  'kdheepak/lazygit.nvim',

  -- Lsp config
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'folke/lsp-colors.nvim',
      'mfussenegger/nvim-lint',
    },
    config = function()
      local nvim_lsp = require('lspconfig')
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
            exportPdf = 'onSave',
          }
        }
      }
      require('mason').setup({
        ui = {
          border = 'none',
          icons = {
            package_installed = '◍',
            package_pending = '◍',
            package_uninstalled = '◍',
          },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities()
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })
      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, 
        { border = 'rounded' }),
      }
      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or 
            {}).filetypes,
            bundle_path = (servers[server_name] or 
            {}).bundle_path,
            root_dir = function()
                return vim.loop.cwd()
            end,
            handlers = handlers
          }
        end,
        }
        require('lint').linters_by_ft = {
          python = { 'golangcilint', 'flake8', 'ruff' },
          typescript = { 'eslint' },
        }
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, 
        {
          callback = function()
            require('lint').try_lint()
          end,
        })
    end
  },
  
  -- Cmp luasnip
  { 'saadparwaiz1/cmp_luasnip' },

  -- Luasnip
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '2.*',
    build = 'make install_jsregexp',
    config = function()
      local ls = require('luasnip')
      local s = ls.snippet
      local sn = ls.snippet_node
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      local r = ls.restore_node
      local l = require('luasnip.extras').lambda
      local rep = require('luasnip.extras').rep
      local p = require('luasnip.extras').partial
      local m = require('luasnip.extras').match
      local n = require('luasnip.extras').nonempty
      local dl = require('luasnip.extras').dynamic_lambda
      local fmt = require('luasnip.extras.fmt').fmt
      local fmta = require('luasnip.extras.fmt').fmta
      local types = require('luasnip.util.types')
      local conds = require('luasnip.extras.expand_conditions')
      ls.config.set_config({
        history = true,
        update_events = 'TextChanged,TextChangedI',
        delete_check_events = 'TextChanged',
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { 'choiceNode', 'Comment' } },
            },
          },
        },
        ext_base_prio = 300,
        ext_prio_increase = 1,
        enable_autosnippets = true,
        store_selection_keys = '<Tab>',
        ft_func = function()
          return vim.split(vim.bo.filetype, '.', true)
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
              t(''),
              sn(nil, { t({ '', '\t\\item ' }), i(1),
              d(2, rec_ls, {}) }),
            })
          )
        end
        local function jdocsnip(args, _, old_state)
          local nodes = {
            t({ '/**', ' * ' }),
            i(1, 'A short Description'),
            t({ '', '' }),
          }
        local param_nodes = {}
        if old_state then
          nodes[2] = i(1, old_state.descr:get_text())
        end
        param_nodes.descr = nodes[2]
        if string.find(args[2][1], ', ') then
          vim.list_extend(nodes, { t({ ' * ', '' }) })
        end
        local insert = 2
        for indx, arg in ipairs(vim.split(args[2][1],
          ', ', true)) do
          arg = vim.split(arg, ' ', true)[2]
          if arg then
            local inode
            if old_state and old_state[arg] then
              inode = i(insert, 
              old_state['arg' .. arg]:get_text())
            else
              inode = i(insert)
            end
            vim.list_extend(
              nodes,
              { t({ ' * @param ' .. arg .. ' ' }), inode, 
              t({ '', '' }) }
            )
            param_nodes['arg' .. arg] = inode
            insert = insert + 1
          end
        end
        if args[1][1] ~= 'void' then
          local inode
          if old_state and old_state.ret then
            inode = i(insert, old_state.ret:get_text())
          else
            inode = i(insert)
          end
          vim.list_extend(
            nodes,
            { t({ ' * ', ' * @return ' }), inode,
            t({ '', '' }) }
          )
          param_nodes.ret = inode
          insert = insert + 1
        end
        if vim.tbl_count(args[3]) ~= 1 then
          local exc = string.gsub(args[3][2], ' throws ', '')
          local ins
          if old_state and old_state.ex then
            ins = i(insert, old_state.ex:get_text())
          else
            ins = i(insert)
          end
          vim.list_extend(
            nodes,
            { t({ ' * ', ' * @throws ' .. exc .. ' ' }), 
            ins,
            t({ '', '' }) }
          )
          param_nodes.ex = ins
          insert = insert + 1
        end
        vim.list_extend(nodes, { t({ ' */' }) })
        local snip = sn(nil, nodes)
        snip.old_state = param_nodes
        return snip
        end
        local function bash(_, _, command)
          local file = io.popen(command, 'r')
          local res = {}
          for line in file:lines() do
            table.insert(res, line)
          end
          return res
        end
        local date_input = function(
          args,
          snip,
          old_state, 
          fmt)
          local fmt = fmt or '%Y-%m-%d'
          return sn(nil, i(1, os.date(fmt)))
        end
        ls.add_snippets('all', {
          s('fn', {
            t('//Parameters: '),
            f(copy, 2),
            t({ '', 'function ' }),
            i(1),
            t('('),
            i(2, 'int foo'),
            t({ ') {', '\t' }),
            i(0),
            t({ '', '}' }),
          }),
          s('class', {
            c(1, {
              t('public '),
              t('private '),
            }),
            t('class '),
            i(2),
            t(' '),
            c(3, {
              t('{'),
              sn(nil, {
                t('extends '),
                r(1, 'other_class', i(1)),
                t(' {'),
              }),
              sn(nil, {
                t('implements '),
                r(1, 'other_class'),
                t(' {'),
              }),
            }),
            t({ '', '\t' }),
            i(0),
            t({ '', '}' }),
          }),
          s(
            'fmt1',
            fmt('To {title} {} {}.', {
              i(2, 'Name'),
              i(3, 'Surname'),
              title = c(1, { t('Mr.'), t('Ms.') }),
            })
          ),
          s(
            'fmt2',
            fmt(
              [[
            foo({1}, {3}) {{
                return {2} * {4}
            }}
            ]],
              {
                i(1, 'x'),
                rep(1),
                i(2, 'y'),
                rep(2),
              }
            )
          ),
          s(
            'fmt3',
            fmt('{} {a} {} {1} {}', {
              t('1'),
              t('2'),
              a = t('A'),
            })
          ),
          s('fmt4', fmt('foo() { return []; }', i(1, 'x'),
          { delimiters = '[]' })),
          s('fmt5', fmta('foo() { return <>; }', i(1, 'x'))),
          s(
            'fmt6',
            fmt('use {} only', { t('this'), t('not this') },
            { strict = false })
          ),
          s('novel', {
            t('It was a dark and stormy night on '),
            d(1, date_input, {},
            { user_args = { '%A, %B %d of %Y' } }),
            t(' and the clocks were striking thirteen.'),
          }),
          ls.parser.parse_snippet(
            'lspsyn',
            'Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}'
          ),
          ls.parser.parse_snippet(
            { trig = 'te', wordTrig = false },
            '${1:cond} ? ${2:true} : ${3:false}'
          ),
          s('cond', {
            t('will only expand in c-style comments'),
          }, {
            condition = function(line_to_cursor, matched_trigger,
              captures)
              return line_to_cursor:match('%s*//')
              end,
          }),
          s('cond2', {
            t('will only expand at the beginning of the line'),
          }, {
            condition = conds.line_begin,
          }),
          s(
            { trig = 'a%d', regTrig = true },
            f(function(_, snip)
              return 'Triggered with ' .. snip.trigger .. '.'
            end, {})
          ),
          s(
            { trig = 'b(%d)', regTrig = true },
            f(function(_, snip)
              return 'Captured Text: ' .. snip.captures[1] .. '.'
            end, {})
          ),
          s({ trig = 'c(%d+)', regTrig = true }, {
            t('will only expand for even numbers'),
          }, {
            condition = function(line_to_cursor, matched_trigger,
              captures)
              return tonumber(captures[1]) % 2 == 0
            end,
          }),
          s('bash', f(bash, {}, { user_args = { 'ls' } })),
          s('transform', {
            i(1, 'initial text'),
            t({ '', '' }),
            l(l._1:match('[^i]*$'):gsub('i', 'o'):gsub(' ', '_'):upper(), 1),
          }),
          s('transform2', {
            i(1, 'initial text'),
            t('::'),
            i(2, 'replacement for e'),
            t({ '', '' }),
            l(l._1:gsub('e', l._2), { 1, 2 }),
          }),
          s({ trig = 'trafo(%d+)', regTrig = true }, {
            l(l.CAPTURE1:gsub('1', l.TM_FILENAME), {}),
          }),
          s('link_url', {
            t('<a href="'),
            f(function(_, snip)
              return snip.env.TM_SELECTED_TEXT[1] or {}
            end, {}),
            t('">'),
            i(1),
            t('</a>'),
            i(0),
          }),
          s('repeat', { i(1, 'text'), t({ '', '' }), rep(1) }),
          s('part', p(os.date, '%Y')),
          s('mat', {
            i(1, { 'sample_text' }),
            t(': '),
            m(1, '%d', 'contains a number', 'no number :('),
          }),
          s('mat2', {
            i(1, { 'sample_text' }),
            t(': '),
            m(1, '[abc][abc][abc]'),
          }),
          s('mat3', {
            i(1, { 'sample_text' }),
            t(': '),
            m(
              1,
              l._1:gsub('[123]', ''):match('%d'),
              'contains a number that isn\'t 1, 2 or 3!'
            ),
          }),
          s('mat4', {
            i(1, { 'sample_text' }),
            t(': '),
            m(1, function(args)
              return (#args[1][1] % 2 == 0 and args[1]) or nil
            end),
          }),
          s('nempty', {
            i(1, 'sample_text'),
            n(1, 'i(1) is not empty!'),
          }),
          s('dl1', {
            i(1, 'sample_text'),
            t({ ':', '' }),
            dl(2, l._1, 1),
          }),
          s('dl2', {
            i(1, 'sample_text'),
            i(2, 'sample_text_2'),
            t({ '', '' }),
            dl(3, l._1:gsub('\n', ' linebreak ') .. l._2, { 1, 2 }),
          }),
        }, {
          key = 'all',
        })
        ls.add_snippets('java', {
          s('fn', {
            d(6, jdocsnip, { 2, 4, 5 }),
            t({ '', '' }),
            c(1, {
              t('public '),
              t('private '),
            }),
            c(2, {
              t('void'),
              t('String'),
              t('char'),
              t('int'),
              t('double'),
              t('boolean'),
              i(nil, ''),
            }),
            t(' '),
            i(3, 'myFunc'),
            t('('),
            i(4),
            t(')'),
            c(5, {
              t(''),
              sn(nil, {
                t({ '', ' throws ' }),
                i(1),
              }),
            }),
            t({ ' {', '\t' }),
            i(0),
            t({ '', '}' }),
          }),
        }, {
          key = 'java',
        })
        ls.add_snippets('tex', {
          s('ls', {
            t({ '\\begin{itemize}', '\t\\item ' }),
            i(1),
            d(2, rec_ls, {}),
            t({ '', '\\end{itemize}' }),
          }),
        }, {
          key = 'tex',
        })
        ls.add_snippets('all', {
          s('autotrigger', {
            t('autosnippet'),
          }),
        }, {
          type = 'autosnippets',
          key = 'all_auto',
        })
        ls.filetype_extend('lua', { 'c' })
        ls.filetype_set('cpp', { 'c' })
        require('luasnip/loaders/from_vscode').lazy_load()
        require('luasnip/loaders/from_vscode').lazy_load({ 
          paths = { './snippets' } })
        ls.filetype_extend('all', { '_' })
        require('luasnip.loaders.from_snipmate').load({
          include = { 'c' } }) -- Load only snippets for c.
        require('luasnip.loaders.from_snipmate').load({
          path = { './my-snippets' } })
        require('luasnip.loaders.from_snipmate').lazy_load()
        require('luasnip.loaders.from_lua').load({ 
          include = { 'c' } })
        require('luasnip.loaders.from_lua').lazy_load({ 
          include = { 'all', 'cpp' } })
    end
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        },
        keymaps = {
          toggle_package_expand = '<CR>',
          install_package = 'i',
          update_package = 'u',
          check_package_version = 'c',
          update_all_packages = 'U',
          check_outdated_packages = 'C',
          uninstall_package = 'X',
          cancel_installation = '<C-c>',
          apply_language_filter = '<C-f>',
          toggle_package_install_log = '<CR>',
          toggle_help = 'g?',
        }
	})
    end
  },

  -- Markdown
  'ixru/nvim-markdown',

  -- Mkdnflow
  {
    'jakewvincent/mkdnflow.nvim',
    lazy = false,
    opts = {
      rocks = 'luautf8',
      perspective = {
        priority = 'root',
        root_tell = '.git',
      },
      new_file_template = {
        use_template = true,
        placeholders = {
          before = {
             title = 'link_title',
             date = 'os_date'
           },
           after = {}
        },
        template = [[
---
title: {{ title }}
created_at: {{ date }}
tags:
---
# {{ title }}
<!--more-->
## {{ title }}
---
Más información,
]]
      },
    }
  },

  -- Neogen
  {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      enabled = true,
      snippet_engine = 'luasnip',
      languages = {
        rust = {
          template = {
            annotation_convention = 'rustdoc',
          }
        },
        python = {
          template = {
            annotation_convention = 'numpydoc',
          }
        },
        javascript = {
          template = {
            annotation_convention = 'tsdoc',
          }
        },
        typescript = {
          template = {
            annotation_convention = 'tsdoc',
          }
        }
      }
    }
  },

  -- Neogit
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = true
  },

  -- Neotest
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-vim-test',
      'nvim-neotest/neotest-python',
      'rouge8/neotest-rust',
      'nvim-neotest/neotest-plenary',
      'rcasia/neotest-bash',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-jest',
      'marilari88/neotest-vitest',
      'thenbe/neotest-playwright',
      'olimorris/neotest-rspec',
      'zidhuss/neotest-minitest',
      'sidlatau/neotest-dart',
      'shunsambongi/neotest-testthat',
      'olimorris/neotest-phpunit',
      'theutz/neotest-pest',
      'jfpedroza/neotest-elixir',
      'Issafalcon/neotest-dotnet',
      'stevanmilic/neotest-scala',
      'mrcjkb/neotest-haskell',
      'markemmons/neotest-deno',
      'rcasia/neotest-java',
      'llllvvuu/neotest-foundry',
      'lawrence-laz/neotest-zig',
      'alfaix/neotest-gtest',
      'weilbith/neotest-gradle',
      'nvim-telescope/telescope.nvim',
      'TheSnakeWitcher/hardhat.nvim',
      'stevearc/overseer.nvim'
    },
    opts = {},
    config = function()
      require('neotest').setup({
        log_level = vim.log.levels.WARN,
        adapters = {
          require('neotest-python')({
            dap = { justMyCode = false },
            args = { '--log-level', 'DEBUG' },
            runner = 'unittest',
            python = '.venv/bin/python',
          }),
          require('neotest-rust')({
            args = { '--no-capture' },
            dap_adapter = 'lldb',
          }),
          require('neotest-bash'),
          require('neotest-plenary'),
          require('neotest-go'),
          require('neotest-jest')({
            jestCommand = 'npm test --',
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require('neotest-vitest'),
          require('neotest-playwright').adapter({
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            }
          }),
          require('neotest-rspec')({
            rspec_cmd = function()
              return vim.tbl_flatten({
                'bundle',
                'exec',
                'rspec',
                'docker',
                '-i',
                '-w',
                '/app',
                '-e',
                'RAILS_ENV=test',
                'app'
              })
            end
          }),
          require('neotest-minitest')({
            test_cmd = function()
              return vim.tbl_flatten({
                'undle',
                'exec',
                'rails',
                'test',
              })
            end
          }),
          require('neotest-dart')({
            command = 'flutter',
            use_lsp = true,
            custom_test_method_names = {},
          }),
          require('neotest-testthat'),
          require('neotest-phpunit'),
          require('neotest-pest'),
          require('neotest-elixir'),
          require('neotest-dotnet'),
          require('neotest-scala'),
          require('neotest-haskell')({
            build_tools = { 'stack', 'cabal' },
            frameworks = { 'tasty', 'hspec', 'sydtest' },
          }),
          require('neotest-deno'),
          require('neotest-java')({
            ignore_wrapper = false,
          }),
          require('neotest-foundry'),
          require('neotest-zig'),
          require('neotest-gtest'),
          require('neotest-gradle'),
          require('neotest-hardhat')
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
              '/',
              '|',
              '\\',
              '-',
              '/',
              '|',
              '\\',
              '-'
              },
              passed = '',
              running = '',
              failed = '',
              skipped = '',
              unknown = '',
              non_collapsible = '─',
              collapsed = '─',
              expanded = '╮',
              child_prefix = '├',
              final_child_prefix = '╰',
              child_indent = '│',
              final_child_indent = ' ',
              watching = '',
          },
          highlights = {
            passed = 'NeotestPassed',
            running = 'NeotestRunning',
            failed = 'NeotestFailed',
            skipped = 'NeotestSkipped',
            test = 'NeotestTest',
            namespace = 'NeotestNamespace',
            focused = 'NeotestFocused',
            file = 'NeotestFile',
            dir = 'NeotestDir',
            border = 'NeotestBorder',
            indent = 'NeotestIndent',
            expand_marker = 'NeotestExpandMarker',
            adapter_name = 'NeotestAdapterName',
            select_win = 'NeotestWinSelect',
            marked = 'NeotestMarked',
            target = 'NeotestTarget',
            unknown = 'NeotestUnknown',
            watching = 'NeotestWatching',
          },
          floating = {
            border = 'rounded',
            max_height = 0.6,
            max_width = 0.6,
            options = {},
          },
          default_strategy = 'integrated',
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
            open = 'botright vsplit | vertical resize 50',
            mappings = {
              expand = { '<CR>', '<2-LeftMouse>' },
              expand_all = 'e',
              output = 'o',
              short = 'O',
              attach = 'a',
              jumpto = 'i',
              stop = 'u',
              run = 'r',
              debug = 'd',
              mark = 'm',
              run_marked = 'R',
              debug_marked = 'D',
              clear_marked = 'M',
              target = 't',
              clear_target = 'T',
              next_failed = 'J',
              prev_failed = 'K',
              watch = 'w',
            },
          },
          benchmark = {
            enabled = true,
          },
          output = {
            enabled = true,
            open_on_run = 'short',
          },
          output_panel = {
            enabled = true,
            open = 'botright split | resize 15',
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
            symbol_queries = {
              python = [[
              ;query
              ;Captures imports and modules they're imported from
              (import_from_statement (_ (identifier) @symbol))
              (import_statement (_ (identifier) @symbol))
              ]],
              go = [[
              ;query
              ;Captures imported types
               (qualified_type name: (type_identifier) @symbol)
              ;Captures package-local and built-in types
              (type_identifier)@symbol
              ;Captures imported function calls and variables/constants
              (selector_expression field: (field_identifier) @symbol)
              ;Captures package-local functions calls
              (call_expression function: (identifier) @symbol)
               ]],
              lua = [[
              ;query
              ;Captures module names in require calls
              (function_call
              name: ((identifier) @function (#eq? @function 'require'))
              arguments: (arguments (string) @symbol))
              ]],
              elixir = function(root, content)
                local lib = require('neotest.lib')
                local query = lib.treesitter.normalise_query(
                'elixir',
                [[;; query
                (call (identifier) @_func_name
                (arguments (alias) @symbol)
                (#match? @_func_name '^(alias|require|import|use)')
                (#gsub! @symbol '.*%.(.*)' '%1')
                )
                ]]
                )
                local symbols = {}
                for _, match, metadata in query:iter_matches(root, content) do
                for id, node in pairs(match) do
                  local name = query.captures[id]
                    if name == 'symbol' then
                      local start_row, start_col, end_row, end_col = node:range()
                      if metadata[id] ~= nil then
                        local real_symbol_length = string.len(metadata[id]['text'])
                        start_col = end_col - real_symbol_length
                      end
                        symbols[#symbols + 1] = { start_row, start_col, end_row, end_col }
                      end
                    end
                  end
                return symbols
              end,
              ruby = [[
              ;query
              ;rspec - class name
              (call
              method: (identifier) @_ (#match? @_ '^(describe|context)')
              arguments: (argument_list (constant) @symbol )
              )
              ;rspec - namespaced class name
              (call
              method: (identifier)
              arguments: (argument_list
              (scope_resolution
              name: (constant) @symbol))
              )
              ]],
              },
              filter_path = nil,
            },
            projects = {},
        })
    end,
  },

  -- Noice
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      notify = {
       view = 'mini'
      },
      messages = {
        view = 'mini'
      },
      errors = {
        view = 'mini'
      }
    }
  },

  -- Notify
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#000000'
    }
  },

  -- Rainbow delimiters
  {
    'HiPhish/rainbow-delimiters.nvim',
     event = 'VeryLazy',
    config = function()
      local rainbow = require('rainbow-delimiters')
        require('rainbow-delimiters.setup')({
          strategy = {
            [''] = rainbow.strategy['global'],
            commonlisp = rainbow.strategy['local'],
          },
          query = {
            [''] = 'rainbow-delimiters',
            latex = 'rainbow-blocks',
            },
            highlight = {
              'RainbowDelimiterRed',
              'RainbowDelimiterYellow',
              'RainbowDelimiterBlue',
              'RainbowDelimiterOrange',
              'RainbowDelimiterGreen',
              'RainbowDelimiterViolet',
              'RainbowDelimiterCyan',
            },
            blacklist = {'c', 'cpp'},
        })
    end,
  },

  -- Remote
  {
    'amitds1997/remote-nvim.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'nvim-telescope/telescope.nvim',
    },
    config = true,
  },

  -- Rest
  {
    'rest-nvim/rest.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
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
        show_curl_command = false,
        show_http_info = true,
        show_headers = true,
        show_statistics = false,
        formatters = {
          json = 'jq',
          html = function(body)
            return vim.fn.system(
            { 'tidy', '-i', '-q', '-' },
            body)
            end
          },
        },
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
        search_back = true,
    },
  },
  {
    'simrat39/rust-tools.nvim',
    config = function()
      local rt = require('rust-tools')
      local opts = {
        tools = {
          runnables = {
            use_telescope = true
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = '',
            other_hints_prefix = ''
          }
        },
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set('n', '<C-space>',
            rt.hover_actions.hover_actions,
            { buffer = bufnr })
            vim.keymap.set('n', '<Leader>a',
            rt.code_action_group.code_action_group,
            { buffer = bufnr })
          end,
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                command = 'clippy'
              }
            }
          }
        },
      }
      require('rust-tools').setup(opts)
    end
  },

  -- Sidebar
  {
    'sidebar-nvim/sidebar.nvim',
    opts = {
      open = false
    }
  },

  -- Smooth Cursor
  {
    'gen740/SmoothCursor.nvim',
    event = 'VeryLazy',
    config = true,
    opts = {
      type = 'exp',
      fancy = {
        enable = true
      }
    },
  },

  -- Surround
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = true
  },

  -- Telescope media files
  {
    'nvim-telescope/telescope-media-files.nvim',
    config = function()
      require('telescope').setup({
        extensions = {
          media_files = {
            filetypes = {'png', 'webp', 'jpg', 'jpeg'},
            find_cmd = 'rg'
          }
        }
      })
    end
  },

  -- Telescope UI Select
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({
              -- Opts
            })
          }
        }
      })
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-dap.nvim',
      'olacin/telescope-gitmoji.nvim',
      'xiyaowong/telescope-emoji.nvim',
      'LinArcX/telescope-command-palette.nvim',
    },
    config = function()
      local lga_actions = require('telescope-live-grep-args.actions')
      require('telescope').setup({
        defaults = {
          mapping = {
            i = {
              ['<C-h>'] = 'which_key'
            }
          }
        },
        pickers = {

        },
        extensions = {
          workspaces = {
            keep_insert = true,
          },
          live_grep_args = {
            auto_quoting = true,
              mappings = {
                i = {
                  ['<C-k>'] = lga_actions.quote_prompt(),
                  ['<C-i>'] = lga_actions.quote_prompt({ 
                    postfix = ' --iglob' }),
                    },
              },
          }, 
          gitmoji = {
            action = function(entry)
              local emoji = entry.value.value
              vim.ui.imput(
              { prompt = 'Enter commit message: ' .. emoji .. ' '},
              function(msg)
                if not msg then
                  return
                end
                local emoji_text = entry.value.text
                vim.cmd(
                ':G commit -m "' .. emoji_text .. ' ' .. msg .. '"'
                )
              end)
            end
          },
          command_palette = {
            { 'File',
              { 'entire selection (C-a)', ':call feedkeys("GVgg")' },
              { 'save current file (C-s)', ':w' },
              { 'save all files (C-A-s)', ':wa' },
              { 'quit (C-q)',  ':qa' },
              { 'file browser (C-i)', ':Telescope file_browser', 1 },
              { 'search word (A-w)', ':Telescope live_greep', 1 },
              { 'git files (A-f)', ':Telescope git_files', 1 },
              { 'files (C-f)', ':Telescope find_files', 1 },
            },
            { 'Help',
              { 'tips', ':help tips' },
              { 'cheatsheet', ':help index' },
              { 'tutorial', ':help tutor' },
              { 'summary', ':help summary' },
              { 'quick reference', ':help quickref' },
              { 'search help(F1)', ':Telescope.builtin help_tags', 1 },
            },
            { 'Code',
              { 'Preview markdown', ':Glow' },
              { 'Reformat code', ':Reformat' }
            },
            { 'Vim',
              { 'reload vimrc',  ':source $MYVIMRC' },
              { 'check health', ':checkhealth' },
              { 'jumps (Alt-j)', ':Telescope jumplist' },
              { 'commands', ':Telescope commands' },
              { 'command history', ':Telescope command_history' },
              { 'registers (A-e)', ':Telescope registers' },
              { 'colorshceme', 'Telescopecolorscheme()', 1 },
              { 'vim options', ':Telescope vim_options' },
              { 'keymaps', ':Telescope keymaps' },
              { 'buffers', ':Telescope buffers' },
              { 'search history (C-h)', ':Telescope search_history' },
              { 'paste mode', ':set paste!' },
              { 'cursor line', ':set cursorline!' },
              { 'cursor column', ':set cursorcolumn!' },
              { 'spell checker', ':set spell!' },
              { 'relative number', ':set relativenumber!' },
              { 'search highlighting (F12)', ':set hlsearch!' },
            }
          },
        }
      })
      require('telescope').load_extension('gitmoji')
      require('telescope').load_extension('emoji')
      require('telescope').load_extension('command_palette')
    end
  },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    -- event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,       -- show icons in the signs column
      sign_priority = 8,  -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      -- BUG: esto es un error
      -- NOTE: acuérdate de hacer esto
      merge_keywords = true,    -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        before = "",                         -- "fg" or "bg" or empty
        keyword = "wide",                    -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",                        -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]],     -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true,                -- uses treesitter to match keywords in comments only
        max_line_len = 400,                  -- ignore lines longer than this
        exclude = {},                        -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of hilight groups or use the hex color if hl not found as a fallback
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
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]],     -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
  }
}}
