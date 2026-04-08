return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Hier definieren wir markdown-oxide
        markdown_oxide = {
          -- Da du es via pacman installiert hast, stellen wir sicher,
          -- dass lspconfig den Pfad findet.
          cmd = { "markdown-oxide" },
          filetypes = { "markdown" },
          root_dir = require("lspconfig.util").root_pattern(
            ".git",
            ".obsidian",
            "index.md"
          ),
          -- Falls du spezifische Einstellungen für Oxide hast, kommen sie hier rein:
          settings = {
            ["markdown-oxide"] = {
              -- Beispiel: Obsidian-Kompatibilität aktivieren
              -- obsidian = { enabled = true }
            },
          },
        },
      },
      -- Wichtig: Verhindert, dass Mason versucht, eine eigene Version zu verwalten,
      -- da du die System-Version (Arch/Pacman) nutzt.
    },
  },
}
