return {
    "liuchengxu/vista.vim",
    config = function()
        local g = vim.g
        local cmd = vim.cmd
        g.vista_icon_indent = '["╰─▸ ", "├─▸ "]'
        g.vista_default_executive = 'ctags'
        cmd [[let g:vista#renderer#enable_icon = 1]]
    end
}
