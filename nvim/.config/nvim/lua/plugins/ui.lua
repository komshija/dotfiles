return {
  {
    'andrew-george/telescope-themes',
    lazy = false,
    config = function()
      require('telescope').load_extension('themes')
    end
  }
}
