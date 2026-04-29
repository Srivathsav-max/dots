return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  lazy = false,
  keys = {
    { "<leader>ff", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in filetree" },
    { "<leader>e",  "<cmd>NvimTreeToggle<cr>",   desc = "Toggle file tree" },
    { "<C-n>",      "<cmd>NvimTreeToggle<cr>",   desc = "Toggle file tree" },
  },
  opts = {
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = { enable = true, update_root = false },
    filters = {
      custom = { ".git", "node_modules", ".vscode" },
      dotfiles = true,
    },
    git = { enable = true, ignore = false },
    renderer = {
      highlight_git = true,
      indent_markers = { enable = true },
      icons = {
        show = { git = true, file = true, folder = true, folder_arrow = true },
      },
    },
    view = {
      side = "left",
      width = 36,
      preserve_window_proportions = true,
    },
    actions = {
      open_file = {
        quit_on_open = false,
        window_picker = { enable = true },
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    -- Auto-open the tree on startup, and follow the file you're editing
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        local is_dir = vim.fn.isdirectory(data.file) == 1
        local no_args = data.file == ""
        if is_dir then vim.cmd.cd(data.file) end
        if is_dir or no_args then
          require("nvim-tree.api").tree.open()
        else
          require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
        end
      end,
    })
  end,
}
