M = {}

local function list_intersection(list1, list2)
  local counts = {}
  local intersection = {}

  for _, item in ipairs(list1) do
    counts[item] = 1
  end

  for _, item in ipairs(list2) do
    counts[item] = (counts[item] or 0) + 1
  end

  for item, count in pairs(counts) do
    if count == 2 then
      table.insert(intersection, item)
    end
  end

  return intersection
end

local function find_items_in_list1_not_in_list2(list1, list2)
  local items_not_in_list = {}
  local temp = {}

  for _, item in ipairs(list1) do
    temp[item] = 1
  end

  for _, item in ipairs(list2) do
    temp[item] = nil
  end

  for item, _ in pairs(temp) do
    table.insert(items_not_in_list, item)
  end

  return items_not_in_list
end

local function install_servers(servers)
  local server_list = table.concat(servers, " ")

  vim.cmd("LspInstall " .. server_list)
end

-- The original code and idea came from heygarrett, here: https://github.com/williamboman/mason-lspconfig.nvim/issues/100#issuecomment-1371523636
function M.create_callback(servers)
  return function(event)
    -- "" (empty) is a "normal buffer", see `:h buftype` for more information
    if vim.bo[event.buf].buftype ~= "" then
      return
    end

    local is_mason_installed, mason_lspconfig = pcall(require, "mason-lspconfig")

    if not is_mason_installed then
      return
    end

    local available_servers = mason_lspconfig.get_available_servers({ filetype = event.match })
    local installed_servers = mason_lspconfig.get_installed_servers()
    local ensure_installed_for_filetype = list_intersection(available_servers, servers)
    local not_yet_installed = find_items_in_list1_not_in_list2(ensure_installed_for_filetype, installed_servers)

    if #not_yet_installed > 0 then
      install_servers(not_yet_installed)
    end
  end
end

return M
