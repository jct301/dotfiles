return {
    "danilshvalov/org-modern.nvim",
    config = function()
        require("orgmode").setup({
            ui = {
                menu = {
                    handler = function(data)
                        require("org-modern.menu"):new({
                            window = {
                                margin = { 1, 0, 1, 0 },
                                padding = { 0, 1, 0, 1 },
                                title_pos = "center",
                                border = "single",
                                zindex = 1000,
                            },
                            icons = {
                                separator = "➜",
                            },
                        }):open(data)
                    end,
                },
            },
        })
    end
}
