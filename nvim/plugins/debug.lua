return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"tpope/vim-fugitive",
	},
	config = function()
		require("dapui").setup()
		require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
		local dap, dapui = require("dap"), require("dapui")
		require("dap-python").test_runner = "pytest"
		require("dap-go").setup({
			dap_configurations = {
				{
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
			},
			delve = {
				path = "dlv",
				initialize_timeout_sec = 20,
				port = "${port}",
			},
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
