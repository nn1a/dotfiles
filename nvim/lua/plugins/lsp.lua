return {
  -- Mason: LSP/DAP/linter installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",  -- Python type checking
        "ruff",     -- Python lint + format (replaces flake8/black/isort)
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
        "bashls",
        "gopls",
        -- rust_analyzer is managed by rustup, not mason (see plugins/rust.lua)
      },
      -- nvim 0.11+: automatic_enable replaces automatic_installation
      automatic_enable = true,
    },
  },

  -- nvim-lspconfig: provides server definitions (cmd, filetypes, root patterns)
  -- We do NOT call lspconfig[server].setup() — use vim.lsp.config() instead
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Apply capabilities to all servers globally
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Server-specific overrides
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- pyright handles type checking only; ruff handles diagnostics + formatting
      vim.lsp.config("pyright", {
        settings = {
          pyright = {
            disableOrganizeImports = true, -- ruff handles imports
          },
          python = {
            analysis = {
              ignore = { "*" }, -- ruff handles lint diagnostics
              typeCheckingMode = "standard",
            },
          },
        },
      })

      -- ruff LSP: diagnostics and code actions (format via conform instead)
      vim.lsp.config("ruff", {
        on_attach = function(client, _)
          -- Disable ruff hover in favor of pyright
          client.server_capabilities.hoverProvider = false
        end,
      })

      -- LSP keymaps — set only when LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K",          vim.lsp.buf.hover,        vim.tbl_extend("force", opts, { desc = "LSP hover" }))
          vim.keymap.set("n", "gd",         vim.lsp.buf.definition,   vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,  vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          vim.keymap.set("n", "gi",         vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          vim.keymap.set("n", "gr",         vim.lsp.buf.references,   vim.tbl_extend("force", opts, { desc = "Go to references" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,  vim.tbl_extend("force", opts, { desc = "Code action" }))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,       vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set("n", "<leader>f",  vim.lsp.buf.format,       vim.tbl_extend("force", opts, { desc = "Format buffer" }))
        end,
      })
    end,
  },

  -- LSP diagnostics UI
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols" },
      { "<leader>cl", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP references" },
    },
    opts = {},
  },
}
