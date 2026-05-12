#!/usr/bin/env bash
set -e

# ═══════════════════════════════════════════════════════════════════════════════
# Lain Terminal Dotfiles Installer
# For Arch Linux / CachyOS / Manjaro
# ═══════════════════════════════════════════════════════════════════════════════

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

print_stage() {
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}  $1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_ok() { echo -e "${GREEN}  ✓ $1${NC}"; }
print_warn() { echo -e "${YELLOW}  ⚠ $1${NC}"; }
print_info() { echo -e "${BLUE}  → $1${NC}"; }

# ─────────────────────────────────────────────────────────────────────────────
# 0. OS Check
# ─────────────────────────────────────────────────────────────────────────────
print_stage "0/10 — Detecting OS"
if ! command -v pacman &>/dev/null; then
    echo -e "${RED}  ✗ This installer is for Arch-based distributions only.${NC}"
    exit 1
fi
print_ok "Arch-based distro detected"

# ─────────────────────────────────────────────────────────────────────────────
# 1. Install system packages
# ─────────────────────────────────────────────────────────────────────────────
print_stage "1/10 — Installing system packages"

PACKAGES=(
    zsh tmux neovim alacritty git
    eza bat fastfetch fzf zoxide lolcat
    ttf-firacode-nerd ttf-fira-code ttf-nerd-fonts-symbols-mono
    fontconfig
)

sudo pacman -Sy --noconfirm
for pkg in "${PACKAGES[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        print_info "Installing $pkg..."
        sudo pacman -S --noconfirm --needed "$pkg" || print_warn "Failed to install $pkg"
    else
        print_ok "$pkg already installed"
    fi
done

# ─────────────────────────────────────────────────────────────────────────────
# 2. Backup existing configs
# ─────────────────────────────────────────────────────────────────────────────
print_stage "2/10 — Creating backups"
mkdir -p "$BACKUP_DIR"

for item in "$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.aliases" "$HOME/.Xresources" \
            "$HOME/.config/alacritty" "$HOME/.config/tmux" \
            "$HOME/.config/nvim" "$HOME/.config/fontconfig"; do
    if [[ -e "$item" ]]; then
        cp -r "$item" "$BACKUP_DIR/" 2>/dev/null || true
    fi
done

print_ok "Backups saved to $BACKUP_DIR"

# ─────────────────────────────────────────────────────────────────────────────
# 3. Install Oh My Zsh
# ─────────────────────────────────────────────────────────────────────────────
print_stage "3/10 — Installing Oh My Zsh"

if [[ ! -d "$HOME/.local/share/oh-my-zsh" ]]; then
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.local/share/oh-my-zsh"
    print_ok "Oh My Zsh installed"
else
    print_ok "Oh My Zsh already exists"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 4. Install Zsh plugins
# ─────────────────────────────────────────────────────────────────────────────
print_stage "4/10 — Installing Zsh plugins"

ZSH_CUSTOM="$HOME/.local/share/oh-my-zsh"

if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    print_ok "powerlevel10k installed"
else
    print_ok "powerlevel10k already exists"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    print_ok "zsh-autosuggestions installed"
else
    print_ok "zsh-autosuggestions already exists"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    print_ok "zsh-syntax-highlighting installed"
else
    print_ok "zsh-syntax-highlighting already exists"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 5. Install TPM (Tmux Plugin Manager)
# ─────────────────────────────────────────────────────────────────────────────
print_stage "5/10 — Installing TPM"

if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
    print_ok "TPM installed"
else
    print_ok "TPM already exists"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 6. Copy configs
# ─────────────────────────────────────────────────────────────────────────────
print_stage "6/10 — Copying configs"

# Alacritty
mkdir -p "$HOME/.config/alacritty"
cp "$SCRIPT_DIR/alacritty/alacritty.toml" "$HOME/.config/alacritty/"
print_ok "Alacritty config copied"

# Tmux
mkdir -p "$HOME/.config/tmux"
cp "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.config/tmux/"
cp "$SCRIPT_DIR/tmux/tmux.conf.local" "$HOME/.config/tmux/"
print_ok "Tmux config copied"

# Neovim
rm -rf "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim"
cp -r "$SCRIPT_DIR/nvim/"* "$HOME/.config/nvim/"
touch "$HOME/.config/nvim/switcher.conf"
print_ok "Neovim config copied"

# Fontconfig
mkdir -p "$HOME/.config/fontconfig"
cp "$SCRIPT_DIR/fontconfig/fonts.conf" "$HOME/.config/fontconfig/"
fc-cache -fv "$HOME/.config/fontconfig" >/dev/null 2>&1 || true
print_ok "Fontconfig copied"

# Zsh
cp "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
cp "$SCRIPT_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
cp "$SCRIPT_DIR/zsh/.aliases" "$HOME/.aliases"
cp "$SCRIPT_DIR/zsh/.Xresources" "$HOME/.Xresources"
print_ok "Zsh configs copied"

# ─────────────────────────────────────────────────────────────────────────────
# 7. Install tmux plugins
# ─────────────────────────────────────────────────────────────────────────────
print_stage "7/10 — Installing tmux plugins"

export TMUX_PLUGIN_MANAGER_PATH="$HOME/.config/tmux/plugins"
tmux start-server \; source-file "$HOME/.config/tmux/tmux.conf" \; run-shell "$HOME/.config/tmux/plugins/tpm/bin/install_plugins" \; kill-server
print_ok "Tmux plugins installed"

# ─────────────────────────────────────────────────────────────────────────────
# 8. Set zsh as default shell
# ─────────────────────────────────────────────────────────────────────────────
print_stage "8/10 — Setting zsh as default shell"

ZSH_PATH="$(command -v zsh)"
if [[ "$SHELL" != "$ZSH_PATH" ]]; then
    sudo chsh -s "$ZSH_PATH" "$(whoami)"
    print_ok "Default shell changed to zsh"
else
    print_ok "zsh is already the default shell"
fi

# ─────────────────────────────────────────────────────────────────────────────
# 9. Install Nvim plugins (headless)
# ─────────────────────────────────────────────────────────────────────────────
print_stage "9/10 — Installing Neovim plugins (this may take a minute)"

nvim --headless -c 'sleep 15' -c 'qall' 2>/dev/null || true
print_ok "Neovim plugins initialized"

# ─────────────────────────────────────────────────────────────────────────────
# 10. Set cursor theme (KDE)
# ─────────────────────────────────────────────────────────────────────────────
print_stage "10/10 — Setting system cursor theme"

if command -v kwriteconfig6 &>/dev/null; then
    kwriteconfig6 --file kcminputrc --group Mouse --key cursorTheme Bibata-Modern-Ice 2>/dev/null || true
    if command -v plasma-apply-cursortheme &>/dev/null; then
        plasma-apply-cursortheme Bibata-Modern-Ice 2>/dev/null || true
    fi
    print_ok "System cursor theme set to Bibata-Modern-Ice"
fi

# ─────────────────────────────────────────────────────────────────────────────
# Done
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo -e "${MAGENTA}╔══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║          🎉 Installation Complete! Welcome to the Wired! 🎉          ║${NC}"
echo -e "${MAGENTA}╚══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Log out and log back in (or start a new terminal)"
echo "  2. Open Alacritty — tmux + zsh + powerlevel10k will start automatically"
echo "  3. Run 'nvim' — LazyVim will finish bootstrapping (~1 min)"
echo ""
echo -e "${BLUE}Useful commands:${NC}"
echo "  t     — smart tmux session manager"
echo "  zi    — interactive zoxide (cd with fzf)"
echo "  f     — fastfetch system info"
echo "  lg    — lazygit"
echo ""
