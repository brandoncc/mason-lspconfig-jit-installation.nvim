# mason-lspconfig-jit-installation.nvim

This plugin provides "just in time" installation of language servers. This is
just a fancy way of saying "language servers are not installed until you are
ready to use them".

https://github.com/brandoncc/mason-lspconfig-jit-installation.nvim/assets/543973/c253c97d-669f-4c40-b4c3-6ace324ad5b4

## Installation and setup

The plugin expects you to provide a specific a list of servers you would like
to install when necessary. If you do not provide this list, initialization will
no-op.

Servers should be specified using the names in the [lspconfig configurations
file](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md).
Alternatively, the [server mappings in
mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua)
can be used as a source. The valid names are the keys in the
`lspconfig_to_package` table.

I use lazy.nvim, so that is the example I'm adding. I will happily accept pull
requests adding more examples.

### lazy.nvim

```lua
{
  "brandoncc/mason-lspconfig-jit-installation.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    servers = {
      "lua_ls",
    },
  },
}
```

## Motivation

[mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)
provides settings called `ensure_installed` and `automatic_installation`.
Neither of these solve my problem, which is that I don't want to install
language servers until I actually need them. I work on a lot of development
servers that are spun up and thrown away quickly, so installing a bunch of
language servers that will not be used is a waste of time. Conversely, removing
my `ensure_installed` setting causes me to forget to install the language
servers that I _do_ need.

## TODO

- [ ] Start newly-installed servers automatically after installation
