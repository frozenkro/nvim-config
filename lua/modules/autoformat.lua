local allowed_lsps = {
  -- 'gopls', -- Handled by go.lua
  'lua_ls',
}

local function is_allowed_lsp(lsp_name)
  for _, val in pairs(allowed_lsps) do
    if val == lsp_name then return true end
  end
  return false
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not is_allowed_lsp(client.name) then return end
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end
})
