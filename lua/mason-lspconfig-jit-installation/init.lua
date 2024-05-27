local util = require("mason-lspconfig-jit-installation.util")

M = {}

function M.setup(opts)
  opts = opts or {}
  opts.servers = opts.servers or {}

  if #opts.servers == 0 then
    print("[mason-lspconfig-jit-installation] No servers specified, nothing to do.")

    return
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("mason-lspconfig-jit-installation", { clear = true }),
    callback = util.create_callback(opts.servers)
  })
end

return M
