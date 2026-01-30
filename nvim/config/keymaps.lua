local comments = require("utils.comments")
local testing = require("utils.testing")

vim.keymap.set(
  "n",
  "<leader>cc",
  comments.insert_prefixed_comment,
  { noremap = true, silent = true, desc = "Generate a signed comment." }
)

-- Note pad
vim.keymap.set("n", "<leader>np", require("gitpad").toggle_gitpad, {})
vim.keymap.set("n", "<leader>nb", require("gitpad").toggle_gitpad_branch)
vim.keymap.set("n", "<leader>nd", function()
  local date_filename = "daily-" .. os.date("%Y-%m-%d.md")
  require("gitpad").toggle_gitpad({ filename = date_filename, title = "Daily notes" })
end, {})
-- Lazygit

-- Debug
vim.keymap.set("n", "<Leader>bp", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")

-- Keybinding
vim.keymap.set("n", "<leader>tm", testing.run_pytest_method_under_cursor, { desc = "Run pytest method under cursor" })
vim.keymap.set("n", "<leader>tf", testing.run_pytest_file, { desc = "Run pytest file" })
