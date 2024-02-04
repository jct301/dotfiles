return {
    "nvim-neotest/neotest",
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
}
