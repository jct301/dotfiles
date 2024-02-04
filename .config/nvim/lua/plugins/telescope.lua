return {
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
                            { prompt = "Enter commit message: " .. emoji .. " " },
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
                        { "entire selection (C-a)",  ":call feedkeys('GVgg')" },
                        { "save current file (C-s)", ":w" },
                        { "save all files (C-A-s)",  ":wa" },
                        { "quit (C-q)",              ":qa" },
                        { "file browser (C-i)",      ":Telescope file_browser", 1 },
                        { "search word (A-w)",       ":Telescope live_grep",    1 },
                        { "git files (A-f)",         ":Telescope git_files",    1 },
                        { "files (C-f)",             ":Telescope find_files",   1 },
                    },
                    { "Help",
                        { "tips",            ":help tips" },
                        { "cheatsheet",      ":help index" },
                        { "tutorial",        ":help tutor" },
                        { "summary",         ":help summary" },
                        { "quick reference", ":help quickref" },
                        { "search help(F1)", ":Telescope help_tags", 1 },
                    },
                    { "Code",
                        { "Preview markdown", ":Glow" },
                        { "Reformat code",    ":Reformat" }
                    },
                    { "Vim",
                        { "reload vimrc",              ":source $MYVIMRC" },
                        { "check health",              ":checkhealth" },
                        { "jumps (Alt-j)",             ":Telescope jumplist" },
                        { "commands",                  ":Telescope commands" },
                        { "command history",           ":Telescope command_history" },
                        { "registers (A-e)",           ":Telescope registers" },
                        { "colorshceme",               ":Telescope colorscheme",    1 },
                        { "vim options",               ":Telescope vim_options" },
                        { "keymaps",                   ":Telescope keymaps" },
                        { "buffers",                   ":Telescope buffers" },
                        { "search history (C-h)",      ":Telescope search_history" },
                        { "paste mode",                ":set paste!" },
                        { "cursor line",               ":set cursorline!" },
                        { "cursor column",             ":set cursorcolumn!" },
                        { "spell checker",             ":set spell!" },
                        { "relative number",           ":set relativenumber!" },
                        { "search highlighting (F12)", ":set hlsearch!" },
                    }
                }
            }
        })
        require("telescope").load_extension("gitmoji")
        require("telescope").load_extension("emoji")
        require("telescope").load_extension("command_palette")
    end
}
