return  {
    "ranjithshegde/orgWiki.nvim",
    config = function()
      require("orgWiki").setup({
         wiki_path = { "~/notes/documents/" },
         diary_path = "~/notes/diary/"
      })
    end
  }
