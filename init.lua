return {
    -- Configure AstroNvim updates
    updater = {
      remote = "origin", -- remote to use
      channel = "stable", -- "stable" or "nightly"
      version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
      branch = "nightly", -- branch name (NIGHTLY ONLY)
      commit = nil, -- commit hash (NIGHTLY ONLY)
      pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
      skip_prompts = false, -- skip prompts about breaking changes
      show_changelog = true, -- show the changelog after performing an update
      auto_quit = false, -- automatically quit the current session after a successful update
      remotes = { -- easily add new remotes to track
        --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
        --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
        --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
      },
    },

    plugins = {
	    { "andweeb/presence.nvim", event = "UIEnter" },
    },
  
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
  
    lsp = {
      -- customize lsp formatting options
      formatting = {
        -- control auto formatting on save
        format_on_save = {
          enabled = true, -- enable or disable format on save globally
          allow_filetypes = { -- enable format on save for specified filetypes only
            -- "go",
          },
          ignore_filetypes = { -- disable format on save for specified filetypes
            -- "python",
          },
        },
        disabled = { -- disable formatting capabilities for the listed language servers
          -- "sumneko_lua",
        },
        timeout_ms = 1000, -- default format timeout
        -- filter = function(client) -- fully override the default formatting function
        --   return true
        -- end
      },
      -- enable servers that you already have installed without mason
      servers = {
        -- "pyright"
      },
    },

    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.prettierd
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,

  
    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    polish = function()
      -- Set up custom filetypes
      -- vim.filetype.add {
      --   extension = {
      --     foo = "fooscript",
      --   },
      --   filename = {
      --     ["Foofile"] = "fooscript",
      --   },
      --   pattern = {
      --     ["~/%.config/foo/.*"] = "fooscript",
      --   },
      -- }
    end,
  }
