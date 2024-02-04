
 -- Neorg https://github.com/nvim-neorg/neorg
 return {
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
  }
