  return {
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
  }
