return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
      },
      window = { width = 30 },
    },
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "]h", gs.next_hunk, opts)
        vim.keymap.set("n", "[h", gs.prev_hunk, opts)
        vim.keymap.set("n", "<leader>gs", gs.stage_hunk, opts)
        vim.keymap.set("n", "<leader>gr", gs.reset_hunk, opts)
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, opts)
        vim.keymap.set("n", "<leader>gb", gs.blame_line, opts)
      end,
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },

  -- Auto close/rename HTML tags
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },

  -- Surround (ys, cs, ds)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Comments (gcc, gc)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Todo comments highlighting
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    },
    opts = {},
  },

  -- Better search/replace
  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>S", '<cmd>lua require("spectre").toggle()<cr>', desc = "Search & Replace" },
    },
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { "<leader>t", "<C-\\>" },
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = { border = "curved" },
    },
  },

  -- Highlight color codes
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = { user_default_options = { tailwind = true } },
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },

  -- Better f/t motions
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
  },

  -- Multi-cursor (optional, vim-visual-multi)
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufReadPre",
  },
}
