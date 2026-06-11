return {
  -- nvim-treesitter v2: parser installer + queries only (no configs.setup)
  -- highlight/indent are now Neovim built-ins; lazy loading is NOT supported
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})

      -- Install missing parsers; :wait() makes it synchronous so parsers
      -- are ready before the first buffer opens (important on a fresh machine)
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "bash",
        "python", "javascript", "typescript", "tsx",
        "html", "css", "json", "yaml", "toml",
        "markdown", "markdown_inline",
        "go", "rust", "c", "cpp",
        "dockerfile", "gitignore",
      }):wait(300000)
    end,
  },

  -- Text objects for treesitter nodes (new API, branch = main)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@function.outer"]  = "V",
            ["@class.outer"]     = "V",
            ["@parameter.outer"] = "v",
          },
        },
      })

      local sel  = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      -- Select text objects
      for key, capture in pairs({
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      }) do
        vim.keymap.set({ "x", "o" }, key, function()
          sel.select_textobject(capture, "textobjects")
        end, { desc = "TS " .. capture })
      end

      -- Move to next/prev function & class
      vim.keymap.set("n", "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
      vim.keymap.set("n", "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function start" })
      vim.keymap.set("n", "]c", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
      vim.keymap.set("n", "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class start" })
    end,
  },
}
