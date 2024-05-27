local util = require("mason-lspconfig-jit-installation.util")

M = {}

function M.setup(opts)
  opts = opts or {}
  opts.servers = opts.servers or {}

  if #opts.servers == 0 then
    print(util.formatted_message("No servers specified, nothing to do."))

    return
  end

  local invalid_servers = util.find_invalid_servers(opts.servers)

  if #invalid_servers > 0 then
    print(util.formatted_message("invalid mason-lspconfig servers specified: " .. table.concat(invalid_servers, ", ")))
    return
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("mason-lspconfig-jit-installation", { clear = true }),
    callback = util.create_callback(opts.servers),
  })
end

return M
