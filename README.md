# Lain Terminal Dotfiles

> "Present day, present time..."

Full terminal environment configuration for Arch Linux / CachyOS / Manjaro.

---

<div align="center">

<pre>
          _..--¯¯¯¯--.._
      ,-''              `-.
    ,'                     `.
   ,                         \
  /                           \
 /          ′.                 \
'          /  ││                ;
;       n /│  │/         │      │
│      / v    /\/`-'v√\'.│\     ,
:    /v`,———         ————.^.    ;
'   │  /′@@`,        ,@@ `\│    ;
│  n│  '.@@/         \@@  /│\  │;
` │ `    ¯¯¯          ¯¯¯  │ \/││
 \ \ \                     │ /\/
 '; `-\          `′       /│/ │′
  `    \       —          /│  │
   `    `.              .' │  │
    v,_   `;._     _.-;    │  /
       `'\│-_`'-''__/^'^' │ │ 
              ¯¯¯¯¯        │ │
    ____ ____ ____ ____    │ /
   ||l |||a |||i |||n ||   ││
   ||__|||__|||__|||__||   ││
   |/__\|/__\|/__\|/__\|   │,
</pre>

<h2>from https://lainos.net/landing.html</h2>

<p>
  <strong>EN:</strong> Aesthetic terminal environment for Linux Mint / Ubuntu / Debian.<br>
  Inspired by <em>Serial Experiments Lain</em> & Kanagawa wave aesthetics.<br>
  <strong>RU:</strong> Эстетичное окружение терминала для Linux Mint / Ubuntu / Debian.<br>
  Вдохновлено <em>Serial Experiments Lain</em> и эстетикой волны Канагава.
</p>

<p>
  <img src="https://img.shields.io/badge/Neovim-0.11+-57A143?logo=neovim&logoColor=white" alt="Neovim">
  <img src="https://img.shields.io/badge/Tmux-3.x-1BB91F?logo=tmux&logoColor=white" alt="Tmux">
  <img src="https://img.shields.io/badge/Zsh-5.9+-F15A24?logo=gnu-bash&logoColor=white" alt="Zsh">
  <img src="https://img.shields.io/badge/Alacritty-latest-FD8019?logo=alacritty&logoColor=white" alt="Alacritty">
  <br>
  <img src="https://img.shields.io/badge/theme-Kanagawa-7E9CD8" alt="Theme">
  <img src="https://img.shields.io/badge/aesthetic-Lain-957FB8" alt="Lain">
  <img src="https://img.shields.io/badge/vibe-cyberpunk-FF00AF" alt="Cyberpunk">
  <img src="https://img.shields.io/badge/status-rice%20ready-76946A" alt="Rice Ready">
</p>

<p>
  <code>#lain</code> · <code>#serialexperimentslain</code> · <code>#anime</code> · <code>#cyberpunk</code> · <code>#ricing</code> · <code>#neovim</code> · <code>#tmux</code> · <code>#zsh</code> · <code>#aesthetic</code> · <code>#weeb</code> · <code># unixporn</code>
</p>

</div>

---

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
git clone https://github.com/NanoTrash/lain-terminal-dotfiles.git
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
