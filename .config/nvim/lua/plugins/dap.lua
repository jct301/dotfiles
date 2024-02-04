return {
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
}
