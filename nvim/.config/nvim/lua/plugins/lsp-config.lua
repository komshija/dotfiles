return {
  {
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
  {
		"echasnovski/mini.extra",
		version = false,
		opts = {},
	},
  {
		"echasnovski/mini.pick",
    version = false,
    opts = {}
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = { ui = { border = "single" } } },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
      "mini.extra",
    },
    lazy = false,
    config = function()
vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("pp-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					local pick = MiniExtra.pickers.lsp

					map("gd", function()
						pick { scope = "definition" }
					end, "Goto definition")

					map("gr", function()
						pick { scope = "references" }
					end, "Goto references")

					map("gI", function()
						pick { scope = "implementation" }
					end, "Goto implementation")
					--
					-- -- Jump to the type of the word under your cursor.
					-- --  Useful when you're not sure what type a variable is and you want to see
					-- --  the definition of its *type*, not where it was *defined*.
					-- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
					--
					-- -- Fuzzy find all the symbols in your current document.
					-- --  Symbols are things like variables, functions, types, etc.
					-- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
					--
					-- -- Fuzzy find all the symbols in your current workspace.
					-- --  Similar to document symbols, except searches over your entire project.
					-- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
					--
					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>r", vim.lsp.buf.rename, "Rename")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>a", vim.lsp.buf.code_action, "Code action", { "n", "x" })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					-- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("pp-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("pp-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds { group = "pp-lsp-highlight", buffer = event2.buf }
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>oh", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
						end, "LSP: Inlay hints")
					end
				end,
			})

      local servers = {
        lua_ls = {},
        clangd = {},
        bashls = {},
        yamlls = {},
        vimls = {},
        sqlls = {},
        pylsp = {},
        neocmake = {},
        dockerls = {},

      };
      local ensure_installed = vim.tbl_keys(servers or {})
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed
      })

      require("mason-lspconfig").setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						-- server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			}

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
