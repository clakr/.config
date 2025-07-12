require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamed"

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set('n', "<D-j>", ":cnext<CR>")
vim.keymap.set('n', "<D-k>", "<cmd>cprev<CR>")

vim.keymap.set("n", "gd", function()
  vim.lsp.buf.definition()
end)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.diagnostic.config({
  virtual_text = true,
})

-- -- working
-- -- Method 2: Override vim.lsp.buf.hover function
-- local original_hover = vim.lsp.buf.hover
--
-- vim.lsp.buf.hover = function(config)
--   config = config or {}
--   config.border = "rounded"
--   return original_hover(config)
-- end
