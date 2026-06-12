-- Claude Code integration via coder/claudecode.nvim
-- Uses WebSocket to communicate with the Claude Code CLI process
return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    opts = {
      -- Terminal appearance
      split_side = "right",
      split_width_percentage = 0.38,
      provider = "snacks",
      auto_close = true,

      -- Behaviour
      track_selection = true,
      focus_after_send = true,

      -- Diff review
      diff_opts = {
        layout = "vertical",
        open_in_new_tab = false,
        keep_terminal_focus = false,
        auto_resize_terminal = true,
      },
    },
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>",        desc = "Claude Code toggle" },
      { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",   desc = "Claude Code focus" },
      { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude Code model" },
      { "<leader>cb", "<cmd>ClaudeCodeAdd<cr>",     desc = "Claude Code add buffer" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",    mode = "v",  desc = "Claude Code send selection" },
      { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude Code accept diff" },
      { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Claude Code deny diff" },
    },
  },

  -- which-key group label
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>c", group = "Claude Code" },
      },
    },
  },
}
