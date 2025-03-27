return {
  { "ellisonleao/gruvbox.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
          -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" },                                                          -- digits
          e = {                                                                         -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = LazyVim.mini.ai_buffer,                                -- buffer
          u = ai.gen_spec.function_call(),                           -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      LazyVim.on_load("which-key.nvim", function()
        vim.schedule(function()
          LazyVim.mini.ai_whichkey(opts)
        end)
      end)
    end,
  },

  {
    "gbprod/yanky.nvim",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {},
        lua_ls = {},
        bashls = {},
        yamlls = {},
        vimls = {},
        sqlls = {},
        pylsp = {},
        neocmake = {},
        groovyls = {},
        dockerls = {},
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "vim",
        "zsh",
        "c",
        "cpp",
        "doxygen",
        "python",
        "rust",
        "regex",
        "sql",
        "tmux",
        "xml",
        "yaml",
        "cmake",
        "csv",
      },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      always_trigger = true,
      extra_trigger_chars = { "(", "{", "," },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "onsails/lspkind.nvim",
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
}
