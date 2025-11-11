vim.keymap.set("n", "d", '"_d', { desc = "Delete character without yanking by pressing delete key" })
vim.keymap.set("v", "d", '"_d', { desc = "Delete selection without yanking by pressing delete key" })
vim.keymap.set("n", "dd", '"_dd', { desc = "Delete line without yanking by pressing double delete key" })
