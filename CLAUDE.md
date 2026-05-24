# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim config forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) (modular variant). It uses **lazy.nvim** for plugin management and targets the latest stable Neovim.

## Plugin Management

All plugins live in `lua/plugins/` as individual files. Each file returns a lazy.nvim spec table. `lua/config/lazy.lua` auto-imports everything in that directory via `{ import = 'plugins' }`.

To add a new plugin, create `lua/plugins/<name>.lua` returning a spec — no registration elsewhere needed.

The `lua/kickstart/plugins/` directory contains optional upstream kickstart plugins (autopairs, debug, gitsigns, indent_line, lint, neo-tree) that are **not currently active** — they're not imported in `lazy.lua`.

## Load Order

`init.lua` loads in this order:
1. `config.options` — vim options + WSL2 clipboard setup (clip.exe/powershell)
2. `config.keymaps` — global keymaps (leader = `<Space>`)
3. `config.autocmds` — global autocommands
4. `config.lazy` — bootstraps lazy.nvim and imports all plugins

## Key Architectural Notes

**LSP**: `lua/plugins/lsp.lua` sets up the full chain: mason → mason-tool-installer → mason-lspconfig → nvim-lspconfig. Only `lua_ls` is enabled by default. jdtls is deliberately excluded from mason-lspconfig handlers — it's managed entirely by `nvim-java` (lazy-loaded on `ft = java`).

**neoconf.nvim** must load before nvim-lspconfig (enforced via `priority = 100`). It enables per-project LSP config via `.neoconf.json`.

**Treesitter**: Uses `branch = 'main'` of nvim-treesitter. Parser activation is done via a `FileType` autocmd rather than the traditional `setup()` approach. To add parsers, extend the `parsers` table in `lua/plugins/treesitter.lua`.

**Formatting**: conform.nvim formats on save for all filetypes except `c`/`cpp`. Manual format: `<leader>f`. Only `stylua` (for Lua) is configured; add other formatters in `formatters_by_ft`.

**Completion**: blink.cmp with LuaSnip snippets. Sources: lsp, path, snippets, lazydev (Lua API completion). `<C-y>` accepts, `<C-k>` toggles signature help.

**Clipboard**: WSL2-specific — copy via `clip.exe`, paste via `powershell.exe Get-Clipboard`. Configured in `lua/config/options.lua`.

## In-Neovim Management Commands

| Command | Purpose |
|---|---|
| `:Lazy` | Plugin status / install / update |
| `:Lazy sync` | Install new plugins and update existing |
| `:Mason` | LSP/tool installer UI |
| `:ConformInfo` | Show active formatters for current buffer |
| `:checkhealth` | Diagnose configuration issues |
