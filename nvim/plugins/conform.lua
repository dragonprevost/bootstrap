return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black" }, -- tell conform to use Black
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  },
}
