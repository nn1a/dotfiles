return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format file",
      },
    },
    opts = {
      formatters_by_ft = {
        lua        = { "stylua" },
        -- ruff_format replaces black + isort (faster, single tool)
        python     = { "ruff_format", "ruff_organize_imports" },
        javascript        = { "prettier" },
        typescript        = { "prettier" },
        javascriptreact   = { "prettier" },
        typescriptreact   = { "prettier" },
        css        = { "prettier" },
        html       = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        markdown   = { "prettier" },
        bash       = { "shfmt" },
        go         = { "gofmt" },
        rust       = { "rustfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- Linting (ruff replaces flake8 for Python; eslint_d for JS/TS)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- ruff LSP already provides Python diagnostics; nvim-lint adds a
        -- second pass for rules not covered by the LSP protocol
        python     = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
