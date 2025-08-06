return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {},
        pyright = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("Makefile")(fname)
          end,
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
              },
            },
          },
        },
      },
    },
  },
}
