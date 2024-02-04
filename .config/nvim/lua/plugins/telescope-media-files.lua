return {
    "nvim-telescope/telescope-media-files.nvim",
    config = function()
        require "telescope".setup {
            extensions = {
                media_files = {
                    filetypes = { "png", "webp", "jpg", "jpeg" },
                    find_cmd = "rg"
                }
            },
        }
    end,
}
