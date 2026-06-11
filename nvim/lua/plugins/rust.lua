-- Requires: rustup + `rustup component add rust-analyzer`
-- rust-analyzer is managed by rustup, not mason, to stay in sync with toolchain
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = "rust",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.g.rustaceanvim = {
        server = {
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            local opts = { buffer = bufnr }
            -- Override K to use Rust hover actions instead of plain hover
            vim.keymap.set("n", "K", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, vim.tbl_extend("force", opts, { desc = "Rust hover actions" }))
            vim.keymap.set("n", "<leader>rr", function()
              vim.cmd.RustLsp("runnables")
            end, vim.tbl_extend("force", opts, { desc = "Rust runnables" }))
            vim.keymap.set("n", "<leader>rd", function()
              vim.cmd.RustLsp("debuggables")
            end, vim.tbl_extend("force", opts, { desc = "Rust debuggables" }))
            vim.keymap.set("n", "<leader>rm", function()
              vim.cmd.RustLsp("expandMacro")
            end, vim.tbl_extend("force", opts, { desc = "Rust expand macro" }))
            vim.keymap.set("n", "<leader>rc", function()
              vim.cmd.RustLsp("openCargo")
            end, vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" }))
            vim.keymap.set("n", "<leader>rp", function()
              vim.cmd.RustLsp("parentModule")
            end, vim.tbl_extend("force", opts, { desc = "Rust parent module" }))
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
              },
              checkOnSave = { command = "clippy" },
              procMacro = { enable = true },
              inlayHints = {
                bindingModeHints    = { enable = true },
                closureCaptureHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
                discriminantHints   = { enable = "always" },
                lifetimeElisionHints = { enable = "skip_trivial" },
              },
            },
          },
        },
      }
    end,
  },

  -- Cargo.toml: show crate versions, update dependencies
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      completion = { cmp = { enabled = true } },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
