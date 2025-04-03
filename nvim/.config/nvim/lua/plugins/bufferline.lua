return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function () 
    require("bufferline").setup( {
      options = {
        close_command = ":Bdelete"
      }
    })
    end
}
