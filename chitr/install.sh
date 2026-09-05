#!/bin/bash
# chitr bootstrap installer
# Detects which shell(s) are installed on this machine and downloads ONLY
# the matching file(s) from GitHub — not all three.

set -e

REPO_RAW="https://raw.githubusercontent.com/kiyoshi-enjo/chitr/main/chitr"

fetch() {
    local url="$1" dest="$2"
    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest"
    elif command -v wget &>/dev/null; then
        wget -q "$url" -O "$dest"
    else
        echo "Need curl or wget installed to continue." >&2
        exit 1
    fi
}

echo "chitr installer"
echo ""

INSTALLED=()

# --- Bash ---
if command -v bash &>/dev/null; then
    fetch "$REPO_RAW/chitr.sh" ~/.chitr.sh
    chmod +x ~/.chitr.sh
    if ! grep -qF 'source ~/.chitr.sh' ~/.bashrc 2>/dev/null; then
        echo 'source ~/.chitr.sh' >> ~/.bashrc
    fi
    echo "✔ bash — downloaded chitr.sh, wired into ~/.bashrc"
    INSTALLED+=("bash")
else
    echo "✘ bash not found — skipped, chitr.sh not downloaded"
fi

# --- Zsh ---
if command -v zsh &>/dev/null; then
    fetch "$REPO_RAW/chitr.zsh" ~/.chitr.zsh
    chmod +x ~/.chitr.zsh
    ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
    if ! grep -qF 'source ~/.chitr.zsh' "$ZSHRC" 2>/dev/null; then
        echo 'source ~/.chitr.zsh' >> "$ZSHRC"
    fi
    echo "✔ zsh  — downloaded chitr.zsh, wired into $ZSHRC"
    INSTALLED+=("zsh")
else
    echo "✘ zsh not found — skipped, chitr.zsh not downloaded"
fi

# --- Fish ---
if command -v fish &>/dev/null; then
    mkdir -p ~/.config/fish
    fetch "$REPO_RAW/chitr.fish" ~/.chitr.fish
    chmod +x ~/.chitr.fish
    FISH_CONFIG=~/.config/fish/config.fish
    touch "$FISH_CONFIG"
    if ! grep -qF 'source ~/.chitr.fish' "$FISH_CONFIG" 2>/dev/null; then
        echo 'source ~/.chitr.fish' >> "$FISH_CONFIG"
    fi
    echo "✔ fish — downloaded chitr.fish, wired into $FISH_CONFIG"
    INSTALLED+=("fish")
else
    echo "✘ fish not found — skipped, chitr.fish not downloaded"
fi

echo ""
if [[ ${#INSTALLED[@]} -eq 0 ]]; then
    echo "No supported shell (bash/zsh/fish) was found. Nothing installed."
    exit 1
fi

# ---- Enhanced ASCII art rating section ----
echo "Done. Installed for: ${INSTALLED[*]}"
echo ""

# A small banner with "CHITR"
echo "  ██████╗██╗  ██╗██╗████████╗██████╗ "
echo " ██╔════╝██║  ██║██║╚══██╔══╝██╔══██╗"
echo " ██║     ███████║██║   ██║   ██████╔╝"
echo " ██║     ██╔══██║██║   ██║   ██╔══██╗"
echo " ╚██████╗██║  ██║██║   ██║   ██║  ██║"
echo "  ╚═════╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝"
echo ""

# A box with star rating request
echo "  ╔══════════════════════════════════════════════════════╗"
echo "  ║  ⭐  ⭐  ⭐ Please rate this project ⭐  ⭐  ⭐      ║"
echo "  ║  https://github.com/kiyoshi-enjo/chitr              ║"
echo "  ║  Your ⭐ makes a huge difference — thank you!       ║"
echo "  ╚══════════════════════════════════════════════════════╝"
echo ""

echo "Open a new terminal and try: chitr --setup"
