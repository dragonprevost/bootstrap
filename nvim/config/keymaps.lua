local comments = require("utils.comments")

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

-- NeoTest
vim.keymap.set("n", "<Leader>tm", require("neotest").run.run, { desc = "Test method" })
vim.keymap.set("n", "<Leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Test file" })
vim.keymap.set("n", "<Leader>td", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Test debug" })
vim.keymap.set("n", "<Leader>ts", function()
  require("neotest").summary.open()
end, { desc = "Test summary" })

-- Debug
vim.keymap.set("n", "<Leader>bp", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")

-- Store the ID of the last test window
local last_test_win = nil

local function run_pytest_method_under_cursor()
  local cwd = vim.fn.getcwd()
  local file = vim.fn.expand("%:.")
  local line = vim.fn.line(".")

  -- Find the method name (full, with underscores)
  local method = nil
  for i = line, 1, -1 do
    local text = vim.fn.getline(i)
    method = text:match("^%s*def%s+(test[%w_]+)%s*%(")
    if method then
      break
    end
  end

  if not method then
    print("No pytest method found under cursor.")
    return
  end

  -- Optionally find the class name if inside a class
  local class_name = nil
  for i = line, 1, -1 do
    local text = vim.fn.getline(i)
    class_name = text:match("^%s*class%s+([%w_]+)")
    if class_name then
      break
    end
  end

  -- Build pytest target
  local target
  if class_name then
    target = string.format("%s::%s::%s", file, class_name, method)
  else
    target = string.format("%s::%s", file, method)
  end

  -- Command with cwd
  local cmd = string.format("cd %s && pytest %s", cwd, target)

  -- Close previous test window if it exists
  if last_test_win and vim.api.nvim_win_is_valid(last_test_win) then
    vim.api.nvim_win_close(last_test_win, true)
  end

  -- Open terminal in split and save its window ID
  vim.cmd("vsplit")
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, term_buf)
  vim.fn.termopen(cmd)
  last_test_win = vim.api.nvim_get_current_win()
end

local function run_pytest_file()
  local cwd = vim.fn.getcwd()
  local file = vim.fn.expand("%:.")

  local target = string.format("%s", file)
  local cmd = string.format("cd %s && pytest %s", cwd, target)

  -- Close previous test window if it exists
  if last_test_win and vim.api.nvim_win_is_valid(last_test_win) then
    vim.api.nvim_win_close(last_test_win, true)
  end

  vim.cmd("split")
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, term_buf)
  vim.fn.termopen(cmd)
  last_test_win = vim.api.nvim_get_current_win()
end

-- Keybinding
vim.keymap.set("n", "<leader>tM", run_pytest_method_under_cursor, { desc = "Run pytest method under cursor" })
vim.keymap.set("n", "<leader>tF", run_pytest_file, { desc = "Run pytest file" })
