return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then return 15 end
      if term.direction == "vertical" then return vim.o.columns * 0.4 end
    end,
    open_mapping = [[<c-\>]],
    direction = "float",
    float_opts = { border = "curved" },
    shade_terminals = true,
  },
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>",      desc = "Terminal (float)" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal (horizontal)" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Terminal (vertical)" },
    { [[<c-\>]],    "<cmd>ToggleTerm<cr>",                       desc = "Toggle terminal" },
  },
}
