local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Barbar
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>")
map("n", "<A-.>", "<Cmd>BufferNext<CR>")
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>")
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>")
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>")
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>")
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>")
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>")
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>")
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>")
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>")
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>")
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>")
map("n", "<A-0>", "<Cmd>BufferLast<CR>")
map("n", "<A-p>", "<Cmd>BufferPin<CR>")
map("n", "<A-c>", "<Cmd>BufferClose<CR>")
map("n", "<C-p>", "<Cmd>BufferPick<CR>")
map("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>")
map("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>")
map("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>")
map("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>")

-- Telescope
map("n", "<leader>fb", "<cmdTelescope buffers<cr>")
map("n", "<leader>fc", "<cmd>telescope commands<cr>")
map("n", "<leader>fd", "<cmd>telescope diagnostics<cr>")
map("n", "<leader>ff", "<cmd>telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>telescope live_grep<cr>")
map("n", "<leader>fgb", "<cmd>telescope git_branches<cr>")
map("n", "<leader>fgc", "<cmd>telescope git_commits<cr>")
map("n", "<leader>fgs", "<cmd>telescope git_status<cr>")
map("n", "<leader>fh", "<cmd>telescope help_tags<cr>")

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
