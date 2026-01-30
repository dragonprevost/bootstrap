-- Eventually port this implementaiton over to a TestRunnerPytest type of
-- module and have a TestRunnerProvider select the TestRunnerPytest instance
-- depending on the current file type. That way the same command can be used to
-- run tests in different languages and with different testing tools.
local M = {}

local last_test_win = nil

function M.run_pytest_method_under_cursor()
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
  vim.cmd("split")
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, term_buf)
  vim.fn.termopen(cmd)
  last_test_win = vim.api.nvim_get_current_win()
end

function M.run_pytest_file()
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

return M
