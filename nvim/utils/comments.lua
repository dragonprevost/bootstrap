local M = {}

function M.insert_prefixed_comment()
	local api = vim.api

	-- Get the comment string for the current buffer
	local commentstring = vim.bo.commentstring
	if commentstring == "" then
		commentstring = "# %s"
	end

	-- Build prefix
	local name = "Dragon P."
	local date = os.date("%Y-%m-%d")
	local prefix = string.format("[%s %s]: ", name, date)
	local comment = string.format(commentstring, prefix)

	-- Get current cursor position
	local row, _ = unpack(api.nvim_win_get_cursor(0))

	-- Get current line's indentation
	local line = api.nvim_get_current_line()
	local indent = line:match("^%s*") or ""

	-- Insert comment above with same indentation
	local new_line = indent .. comment
	api.nvim_buf_set_lines(0, row - 1, row - 1, false, { new_line })

	-- Move cursor to the **end of the inserted comment**
	local new_row = row -- inserted line is above, so row stays the same for the comment
	local new_col = #new_line
	api.nvim_win_set_cursor(0, { new_row, new_col })
end

return M
