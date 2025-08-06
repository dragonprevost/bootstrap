return {
	"yujinyuz/gitpad.nvim",
	config = function()
		local gitpad = require("gitpad")
		vim.keymap.set("n", "<leader>nd", function()
			local date_filename = "daily-" .. os.date("%Y-%m-%d.md")
			gitpad.toggle_gitpad({ filename = date_filename, title = "Daily notes" })
		end, {})
	end,
}
