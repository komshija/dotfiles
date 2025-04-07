return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mini.snippets"
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'enter' },

      snippets = { preset = "mini_snippets" },
      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
					--      lazydev = {
					-- 	name = "LazyDev",
					-- 	module = "lazydev.integrations.blink",
					-- 	score_offset = 100,
					-- },
        }
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
		"echasnovski/mini.snippets",
		version = false,
		config = function()
			local gen_loader = require("mini.snippets").gen_loader
			require("mini.snippets").setup {
				snippets = {
					-- gen_loader.from_file "~/.config/nvim/snippets/global.json",
					-- gen_loader.from_lang(),
				},
			}
		end,
	},
}
