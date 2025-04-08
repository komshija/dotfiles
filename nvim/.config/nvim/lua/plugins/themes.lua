return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
  },
  {
    "EdenEast/nightfox.nvim"
  },
  {
    "rebelot/kanagawa.nvim"
  },
  {
    'folke/tokyonight.nvim'
  },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      vim.cmd.colorscheme "github_dark_colorblind"
    end
  },
}
