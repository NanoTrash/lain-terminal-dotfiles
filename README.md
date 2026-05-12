# Lain Terminal Dotfiles

> "Present day, present time..."

Full terminal environment configuration for Arch Linux / CachyOS / Manjaro.

## What's included

| Component | Description |
|-----------|-------------|
| **Alacritty** | GPU-accelerated terminal with Kanagawa theme, transparency, FiraCode Nerd Font |
| **tmux** | Oh My Tmux! with Kanagawa colors, persistent right-click menu, bottom status bar |
| **zsh** | Oh My Zsh + Powerlevel10k + zsh-autosuggestions + zsh-syntax-highlighting + zoxide |
| **neovim** | LazyVim with Kanagawa theme, dashboard, LSP, transparent background |
| **fontconfig** | Nerd Font fallback for 100+ monospace fonts |

## Screenshot

Alacritty → tmux → zsh → nvim with unified Kanagawa color scheme.

## Prerequisites

- Arch Linux / CachyOS / Manjaro (pacman-based)
- `git`, `curl`, `sudo`
- Internet connection

## Quick Install

```bash
git clone https://github.com/yourusername/lain-terminal-dotfiles.git
cd lain-terminal-dotfiles
./install.sh
```

Then **log out and log back in** (or start a new terminal).

## What the installer does

1. Installs all system packages (zsh, tmux, neovim, alacritty, fonts, tools)
2. Backs up existing configs to `~/.config-backup-<timestamp>`
3. Installs Oh My Zsh, Powerlevel10k, zsh plugins
4. Installs TPM and all tmux plugins automatically
5. Copies all dotfiles to their locations
6. Sets zsh as default shell
7. Bootstraps Neovim plugins (LazyVim)
8. Sets Bibata-Modern-Ice system cursor theme (KDE)

## Features

- **Alacritty**: launches tmux automatically on start
- **tmux**: right-click context menu stays open until you select an item (`-O` flag)
- **zsh**: instant prompt with public IP + DNS display
- **nvim**: LazyVim with custom dashboard, transparent UI, Kanagawa colors

## Key bindings

### tmux
| Key | Action |
|-----|--------|
| `Ctrl+B` | Prefix key |
| `Ctrl+B R` | Reload config |
| `Right click` | Context menu (copy, paste, split, kill pane) |
| `Ctrl+Shift+Left/Right` | Reorder windows |

### zsh
| Key | Action |
|-----|--------|
| `t` | Smart tmux session manager |
| `zi` | Interactive zoxide (fuzzy cd) |
| `f` | fastfetch system info |
| `lg` | lazygit |

### nvim
| Key | Action |
|-----|--------|
| `Space` | Leader key |
| `<leader>e` | Toggle file explorer (neo-tree) |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |

## License

WTFPL / MIT — same as the original configs.

## Credits

- [gpakosz/.tmux](https://github.com/gpakosz/.tmux) — Oh My Tmux!
- [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k) — zsh theme
- [LazyVim](https://github.com/LazyVim/LazyVim) — Neovim config
- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) — Color scheme
