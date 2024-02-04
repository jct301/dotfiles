
  -- Colorschemes

  -- Catppuccin https://github.com/catppuccin/nvim
  -- latte, frappe, mocha, macchiato
  return {
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
  }
