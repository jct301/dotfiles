-- Autosave https://github.com/pocco81/auto-save.nvim
return {
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
}
