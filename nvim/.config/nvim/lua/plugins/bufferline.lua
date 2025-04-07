return {
  { 'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function () 
    require("bufferline").setup( {
      options = {
        close_command = ":Bdelete"
      }
    })
    end
  },
  {
		"echasnovski/mini.bufremove",
		version = false,
		keys = { {
			"<leader>bd",
			function()
				MiniBufremove.delete()
			end,
			desc = "Delete buffer",
		} },
		opts = {},
	},
}
