-- Note pad
vim.keymap.set("n", "<leader>np", require("gitpad").toggle_gitpad, {})
vim.keymap.set("n", "<leader>nb", require("gitpad").toggle_gitpad_branch)
vim.keymap.set("n", "<leader>nd", function()
	local date_filename = "daily-" .. os.date("%Y-%m-%d.md")
	require("gitpad").toggle_gitpad({ filename = date_filename, title = "Daily notes" })
end, {})
-- Lazygit
--
-- NeoTest
vim.keymap.set("n", "<Leader>tm", require("neotest").run.run)
vim.keymap.set("n", "<Leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end)
vim.keymap.set("n", "<Leader>td", function()
	require("neotest").run.run({ strategy = "dap" })
end)
vim.keymap.set("n", "<Leader>ts", function()
	require("neotest").summary.open()
end)

-- Debug
vim.keymap.set("n", "<Leader>bp", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
