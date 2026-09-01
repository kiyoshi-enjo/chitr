# chitr
chitr — A smart terminal launcher for images, videos, and audio. Detects file type, lets you pick GUI or CLI apps, and automatically falls back if one fails. Pure Bash, zero dependencies.

# 🖼️ chitr

**A smart terminal tool to open images, videos, and audio files – quickly and easily.**

You type the file name, and chitr figures out what kind of file it is. Then it opens it with the best app available. If that app fails, it automatically tries another one. No more guessing which player works.

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Platform: Linux](https://img.shields.io/badge/Platform-Linux-blue.svg)
![Shell: Bash](https://img.shields.io/badge/Shell-Bash-4EAA25.svg)

---

## ✨ What It Does

- 🔍 **Auto file-type detection** – Uses `file` command or extension to know if it's an image, video, or audio.
- 🖥️ **GUI or Terminal** – Choose between window apps (GUI) or apps that run inside the terminal.
- 🔄 **Smart fallback** – If the chosen app can't open the file, chitr automatically tries other installed apps of the same type.
- ⌨️ **Command-not-found integration** – Just type a media file name in your shell, and chitr opens it (works with Bash/Zsh).
- 📦 **Setup mode** – `--setup` installs missing apps using your system package manager (apt, dnf, pacman, etc.).
- 📋 **List apps** – `--list` shows which viewers/players are installed and which are missing.
- ⚡ **Lightweight** – Pure Bash, no extra dependencies.

---

## 🚀 Installation

```bash
git clone https://github.com/USERNAME/chitr.git
cd chitr
chmod +x chitr
sudo cp chitr /usr/local/bin/

## Or download directly:
curl -sSL https://raw.githubusercontent.com/USERNAME/chitr/main/chitr -o chitr
chmod +x chitr
sudo mv chitr /usr/local/bin/
