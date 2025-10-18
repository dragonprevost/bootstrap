return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = {
              justMyCode = true,
              --console = "integratedTerminal",
            },
            args = { "--log-level", "DEBUG", "--quiet", "-vv" },
            runner = "pytest",
            python = vim.fn.getcwd() .. "/venv/bin/python",
            pytest_discover_instances = true,
          }),
        },
      })
    end,
  },
}
