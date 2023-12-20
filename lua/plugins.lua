return {
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {},
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    keys = {
      { "s", "<CMD>HopWord<CR>", silent = true, noremap = true },
    },
    opts = { keys = "etovxqpdygfblzhckisuran" },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        hide_inactive_statusline = true,
        dim_inactive = true,
        lualine_bold = true,
      })
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "e", "<CMD>Neotree<CR>", silent = true, noremap = true },
    },
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        position = "float",
        mappings = {
          ["<space>"] = { "toggle_node", nowait = false },
          ["a"] = { "add", config = { show_path = "relative" } },
          ["d"] = "delete",
          ["m"] = "move",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["e"] = "close_window",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
      filesystem = {
        filtered_items = {
          hide_by_name = { "node_modules" },
          hide_gitignored = false,
        },
        window = {
          mappings = {
            ["."] = "toggle_hidden",
            ["u"] = "navigate_up",
            ["o"] = "set_root",
          },
        },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      signcolumn = true,
      numhl = true,
      linehl = true,
    },
  },

  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "q", "<CMD>LazyGit<CR>", silent = true, noremap = true },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1
      vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<CMD>ToggleTerm<CR>", silent = true, noremap = true },
    },
    config = function()
      require("toggleterm").setup({
        direction = "float",
      })

      vim.api.nvim_create_autocmd({ "TermEnter" }, {
        pattern = { "term://*toggleterm#*" },
        callback = function()
          vim.api.nvim_set_keymap("t", "<C-\\>", '<CMD>exe v:count1 . "ToggleTerm"<CR>', { silent = true })
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = { "yioneko/nvim-yati" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "json",
          "yaml",
          "tsx",
          "typescript",
          -- "markdown",
        },
        auto_install = false,
        highlight = { enable = true },
        autotag = { enable = true },
        indent = { enable = false },
        yati = { enable = true, disable = { "markdown" } },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.tsserver.setup({})
      lspconfig.tailwindcss.setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_)
          vim.keymap.set('n', 'F',  '<cmd>lua vim.lsp.buf.hover()<CR>')
          vim.keymap.set('n', 'f', '<cmd>lua vim.diagnostic.open_float()<CR>')
          vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
          vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

          vim.fn.sign_define("DiagnosticSignError", { text = "🔴" })
          vim.fn.sign_define("DiagnosticSignWarn", { text = "🟡" })
          vim.fn.sign_define("DiagnosticSignInfo", { text = "🔵" })
          vim.fn.sign_define("DiagnosticSignHint", { text = "🟢" })

          vim.o.pumheight = 15
          vim.diagnostic.config({ underline = true, virtual_text = false })
        end
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    config = function()
      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
      local event = "BufWritePre"
      local async = event == "BufWritePost"

      require("null-ls").setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
              buffer = bufnr,
              group = group,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = async })
              end,
              desc = "[lsp] format on save",
            })
          end
        end,
      })
    end,
  },

  {
    "MunifTanjim/prettier.nvim",
    lazy = false,
    config = function()
      local prettier = require("prettier")

      prettier.setup({
        bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
        filetypes = {
          "javascript",
          "javascriptreact",
          "json",
          "typescript",
          "typescriptreact",
          "yaml",
        },
      })
    end
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        experimental = {
          ghost_text = true,
        },
        formatting = {
          format = function(entry, item)
            item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              path = "[Path]",
              luasnip = "[Snippet]",
            })[entry.source.name]
            return item
          end,
        },
      })
    end,
  },
}
