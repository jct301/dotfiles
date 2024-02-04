return  {
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
  }
