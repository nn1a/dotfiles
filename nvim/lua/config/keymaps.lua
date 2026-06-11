local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Splits
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal window sizes" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Indenting in visual mode keeps selection
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Better paste in visual mode
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" })

-- File tree (Neo-tree)
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Focus file explorer" })

-- Diagnostics (always available, no LSP needed)
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
-- LSP keymaps are set per-buffer via LspAttach in plugins/lsp.lua

-- Git (Gitsigns)
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })

-- Terminal
map("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Which-key hint
map("n", "<leader>?", "<cmd>WhichKey<cr>", { desc = "Show keymaps" })
