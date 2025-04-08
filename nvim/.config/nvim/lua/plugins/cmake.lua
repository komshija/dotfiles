return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      direction = 'float'
    },
    config = function() 
      vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal'})
    end
  },
  {
    "Civitasv/cmake-tools.nvim",
    lazy = false,
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/overseer.nvim",
    },
    config = function()
      require('cmake-tools').setup{}
      require('toggleterm').setup{}
    end
  }
}
