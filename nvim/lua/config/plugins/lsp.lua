return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local capabilities = require('blink-cmp').get_lsp_capabilities()

    vim.lsp.config('lua_ls', {
      capabilities = capabilities
    })

    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = '/opt/homebrew/lib/node_modules/@vue/language-server',
            languages = { 'vue' }
          }
        }
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreat', 'vue' }
    })

    vim.lsp.enable({
      'lua_ls',
      'ts_ls',
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end
          })
        end
      end
    })
  end
}
