-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>zm", function()
  require("zen-mode").setup({
    window = {
      backdrop = 1.0,
      width = 90,
      options = {},
    },
  })
  require("zen-mode").toggle()
  vim.wo.wrap = false
  vim.wo.number = true
  vim.wo.rnu = true
end)

vim.keymap.set("n", "<leader>zM", function()
  require("zen-mode").setup({
    window = {
      backdrop = 0.0,
      width = 90,
      options = {},
    },
  })
  require("zen-mode").toggle()
  vim.wo.wrap = false
  vim.wo.number = true
  vim.wo.rnu = true
end)

-- local dap = require("dap")
-- local dapui = require("dapui")
--
-- vim.keymap.set("n", "<F5>", function()
--   dap.continue()
-- end, { desc = "Start/Continue Debugging" })
-- vim.keymap.set("n", "<F10>", function()
--   dap.step_over()
-- end, { desc = "Step Over" })
-- vim.keymap.set("n", "<F11>", function()
--   dap.step_into()
-- end, { desc = "Step Into" })
-- vim.keymap.set("n", "<F12>", function()
--   dap.step_out()
-- end, { desc = "Step Out" })
-- vim.keymap.set("n", "<leader>db", function()
--   dap.toggle_breakpoint()
-- end, { desc = "Toggle Breakpoint" })
-- vim.keymap.set("n", "<leader>dr", function()
--   dap.repl.open()
-- end, { desc = "Open Debug REPL" })
-- vim.keymap.set("n", "<leader>du", function()
--   dapui.toggle()
-- end, { desc = "Toggle Debug UI" })
