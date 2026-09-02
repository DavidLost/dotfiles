local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Prefer ts_ls (new server name). Fallback to tsserver for older setups.
local ts_server = lspconfig.ts_ls and "ts_ls" or "tsserver"
lspconfig[ts_server].setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
