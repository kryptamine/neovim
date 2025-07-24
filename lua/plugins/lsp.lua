return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {},
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      require('mason-lspconfig').setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Map the combined function to the <leader>ca key binding
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          map('<leader>b', vim.lsp.buf.hover, 'Display variable type')

          map('<leader>cm', function()
            vim.lsp.buf.code_action {
              context = {
                ---@diagnostic disable-next-line: assign-type-mismatch
                only = { 'source.addMissingImports.ts' },
                diagnostics = {},
              },
              apply = true,
            }

            vim.lsp.buf.code_action {
              context = {
                ---@diagnostic disable-next-line: assign-type-mismatch
                only = { 'source.removeUnused.ts' },
                diagnostics = {},
              },
              apply = true,
            }
          end, '[C]ode [M]issing Imports')
        end,
      })

      local servers = {
        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              tsserver = {
                maxTsServerMemory = 15000,
              },
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
              preferences = {
                importModuleSpecifier = 'non-relative', -- Enable named imports
                importModuleSpecifierEnding = 'auto', -- Optional, auto appends `.js` for JS/TS files
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        clangd = {
          cmd = { 'clangd', '--background-index' },
          single_file_support = true,
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'lua_ls',
        'stylua',
        'html',
        'cssls',
        'clangd',
        'eslint',
        'eslint_d',
        'gopls',
        'vtsls',
        'black',
        'isort',
        'prettier',
        'prettierd',
        'intelephense',
        'terraformls',
        'tflint',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for server_name, config in pairs(servers) do
        vim.lsp.config(server_name, config)
      end
    end,
  },
}
