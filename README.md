# nvim-lsp-basics

The shiny new built-in LSP client is awesome, but a large portion of its features don't have any associated mappings or ex-commands, unlike the `tags` feature. This kind of configuration is instead left up to the user, which can result in a lot of boilerplate.

This plugin attempts to fix that by providing basic mappings and user-commands.

## Installation

```lua
-- packer.nvim
use 'nanotee/nvim-lsp-basics'

-- paq-nvim
paq 'nanotee/nvim-lsp-basics'
```

```vim
" vim-plug
Plug 'nanotee/nvim-lsp-basics'
```

## Usage

Setup the plugin with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

```lua
require'lspconfig'.<languageserver>.setup{
    on_attach = function(client, bufnr)
        local basics = require('lsp_basics')

        basics.make_lsp_commands(client, bufnr)
        basics.make_lsp_mappings(client, bufnr)
    end
}
```

## User Commands

See [the docs](doc/lsp-basics.txt) for a list of user commands

Commands are created per buffer and only if the server has the associated capability. This way it's easy to tell at a glance what the server does or doesn't support.

Tab-completion is provided for commands that accept arguments (when applicable).

## Mappings

TODO!

## Other cool LSP plugins

- [glepnir/lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim)
- [weilbith/nvim-lsp-smag](https://github.com/weilbith/nvim-lsp-smag)
- [kosayoda/nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
