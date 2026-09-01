# 🖼️ chitr

**A smart terminal tool to open images, videos, and audio files — quickly and easily.**

`chitr` is a lightweight Bash-based media opener that automatically detects whether a file is an **image, video, or audio**, then opens it using the best available application.

If the preferred application isn't installed or fails to open the file, `chitr` automatically falls back to another compatible application.

**No guessing. No complicated configuration. Just open your media.**

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Platform: Linux](https://img.shields.io/badge/Platform-Linux-blue.svg)
![Shell: Bash](https://img.shields.io/badge/Shell-Bash-4EAA25.svg)

---

## ✨ Features

* 🔍 **Automatic File Detection**
  Detects images, videos, and audio using the `file` command or file extension.

* 🖥️ **GUI & Terminal Support**
  Choose between graphical applications and terminal-based viewers/players.

* 🔄 **Smart Fallback System**
  If one application fails, `chitr` automatically tries another compatible application.

* ⌨️ **Shell Integration**
  With shell integration enabled, you can simply type a media filename and let `chitr` handle the rest.

* 📦 **Automatic Setup**
  Use `--setup` to install recommended applications through your system's package manager.

* 📋 **Application Manager**
  Use `--list` to see which supported applications are installed and which are missing.

* ⚡ **Lightweight & Fast**
  Written entirely in Bash with no heavy dependencies.

* 🐧 **Linux First**
  Designed specifically for Linux systems.

---

# 🚀 Installation
---

## 🐧 Ubuntu / Debian / Linux Mint

### 1. Install Git

```bash
sudo apt update
sudo apt install git -y
```

### 2. Clone the Repository

```bash
git clone https://github.com/kiyoshi-enjo/chitr.git
cd chitr
```

### 3. Make the Script Executable

```bash
chmod +x chitr.sh
```

### 4. Copy `chitr.sh`

```bash
cp chitr.sh ~/.chitr.sh
```

### 5. Add chitr to Bash

```bash
echo 'source ~/.chitr.sh' >> ~/.bashrc
```

### 6. Reload Bash

```bash
source ~/.bashrc
```

### 7. Run Setup

```bash
chitr --setup
```

---

## 🎩 Fedora

### 1. Install Git

```bash
sudo dnf install git -y
```

### 2. Clone the Repository

```bash
git clone https://github.com/kiyoshi-enjo/chitr.git
cd chitr
```

### 3. Make the Script Executable

```bash
chmod +x chitr.sh
```

### 4. Copy `chitr.sh`

```bash
cp chitr.sh ~/.chitr.sh
```

### 5. Add chitr to Bash

```bash
echo 'source ~/.chitr.sh' >> ~/.bashrc
```

### 6. Reload Bash

```bash
source ~/.bashrc
```

### 7. Run Setup

```bash
chitr --setup
```

---

## 🏹 Arch Linux / Manjaro / EndeavourOS

### 1. Install Git

```bash
sudo pacman -Sy git
```

### 2. Clone the Repository

```bash
git clone https://github.com/kiyoshi-enjo/chitr.git
cd chitr
```

### 3. Make the Script Executable

```bash
chmod +x chitr.sh
```

### 4. Copy `chitr.sh`

```bash
cp chitr.sh ~/.chitr.sh
```

### 5. Add chitr to Bash

```bash
echo 'source ~/.chitr.sh' >> ~/.bashrc
```

### 6. Reload Bash

```bash
source ~/.bashrc
```

### 7. Run Setup

```bash
chitr --setup
```

---

## 🦎 openSUSE

### 1. Install Git

```bash
sudo zypper install git
```

### 2. Clone the Repository

```bash
git clone https://github.com/kiyoshi-enjo/chitr.git
cd chitr
```

### 3. Make the Script Executable

```bash
chmod +x chitr.sh
```

### 4. Copy `chitr.sh`

```bash
cp chitr.sh ~/.chitr.sh
```

### 5. Add chitr to Bash

```bash
echo 'source ~/.chitr.sh' >> ~/.bashrc
```

### 6. Reload Bash

```bash
source ~/.bashrc
```

### 7. Run Setup

```bash
chitr --setup
```

---

## 🏢 RHEL / Rocky Linux / AlmaLinux

### 1. Install Git

```bash
sudo dnf install git -y
```

### 2. Clone the Repository

```bash
git clone https://github.com/kiyoshi-enjo/chitr.git
cd chitr
```

### 3. Make the Script Executable

```bash
chmod +x chitr.sh
```

### 4. Copy `chitr.sh`

```bash
cp chitr.sh ~/.chitr.sh
```

### 5. Add chitr to Bash

```bash
echo 'source ~/.chitr.sh' >> ~/.bashrc
```

### 6. Reload Bash

```bash
source ~/.bashrc
```

### 7. Run Setup

```bash
chitr --setup
```

---

## 🌀 Alpine Linux

### 1. Install Git

```bash
sudo apk add git
```

### 2. Clone the Repository

```bash
git clone https://github.com/kiyoshi-enjo/chitr.git
cd chitr
```

### 3. Make the Script Executable

```bash
chmod +x chitr.sh
```

### 4. Copy `chitr.sh`

```bash
cp chitr.sh ~/.chitr.sh
```

### 5. Add chitr to Bash

```bash
echo 'source ~/.chitr.sh' >> ~/.bashrc
```

### 6. Reload Bash

```bash
source ~/.bashrc
```

### 7. Run Setup

```bash
chitr --setup
```

---

## 🐧 Other Linux Distributions

If your distribution is not listed above, make sure **Git** and **Bash** are installed, then run:

```bash
git clone https://github.com/kiyoshi-enjo/chitr.git
cd chitr

chmod +x chitr.sh

cp chitr.sh ~/.chitr.sh

echo 'source ~/.chitr.sh' >> ~/.bashrc

source ~/.bashrc

chitr --setup
```

🎉 **That's it! chitr is ready to use.**
---

## 📦 Usage

### Open a File

```bash
chitr photo.jpg
chitr video.mp4
chitr song.mp3
```

`chitr` automatically determines the file type and selects a suitable application.

```bash
photo.jpg
video.mp4
song.mp3
```

### Available Commands

```bash
chitr --setup
```

Install recommended applications.

```bash
chitr --list
```

Show installed and missing applications.

```bash
chitr --help
```

Show the help menu.

---

## ⌨️ Shell Integration

Once shell integration is enabled, you can open a media file directly by typing its filename:

```bash
$ photo.jpg
```

Instead of manually choosing an image viewer, `chitr` detects the file and opens it automatically.

Shell integration is intended to work with:

* Bash
* Zsh

---

# 🛠️ Supported Applications

## 🖼️ Images

### GUI

```text
feh
geeqie
eog
gthumb
nomacs
gwenview
qview
shotwell
xnviewmp
gimp
```

### Terminal / CLI

```text
jp2a
chafa
cacaview
catimg
img2sixel
viu
timg
w3m
```

---

## 🎬 Videos

### GUI

```text
vlc
mpv
celluloid
totem
smplayer
parole
kaffeine
mplayer
```

### Terminal / CLI

```text
mpv
mplayer
vlc
```

---

## 🎵 Audio

### GUI

```text
vlc
audacious
rhythmbox
clementine
lollypop
elisa
deadbeef
```

### Terminal / CLI

```text
mpv
mplayer
mpg123
ffplay
```
---

# 📋 Check Available Apps

To see which applications are currently installed:

```bash
chitr --list
```

Example:

```text
Images
────────────────────────────
✓ feh
✓ chafa
✗ geeqie
✓ gthumb

Videos
────────────────────────────
✓ mpv
✓ vlc
✗ celluloid

Audio
────────────────────────────
✓ mpv
✗ mpg123
✓ ffplay
```

---

# 🧠 How It Works

The basic workflow is simple:

```text
                 ┌──────────────┐
                 │   chitr FILE │
                 └──────┬───────┘
                        │
                        ▼
               ┌─────────────────┐
               │ Detect File Type│
               └────────┬────────┘
                        │
          ┌─────────────┼─────────────┐
          ▼             ▼             ▼
       🖼️ Image       🎬 Video      🎵 Audio
          │             │             │
          ▼             ▼             ▼
      Find Apps      Find Apps      Find Apps
          │             │             │
          └─────────────┼─────────────┘
                        ▼
                Open With Best App
                        │
                        ▼
                 App Fails?
                   /       \
                 No         Yes
                 │           │
                 ▼           ▼
                Done     Try Fallback
```

---

# 🔮 Coming Soon

Planned features include:

* 🍎 Support for MAC

* ⚙️ Config file support

  * `~/.config/chitr/config`

* 🔍 Fuzzy finder integration

  * `fzf`

* 📂 Open multiple files at once

* 🌐 Open URLs directly

* 🧩 Plugin system for new file types

* 🕘 Recently opened file history

* 🐚 Improved Bash & Zsh & fish shell completions

* 🎨 Custom application priority

* 🧪 Better error reporting and diagnostics

---

# ☕ Support the Project

If **chitr** is useful to you and you'd like to support its development, you can buy me a coffee! ☕❤️

<a href="https://ko-fi.com/YOUR_USERNAME">
  <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Buy Me a Coffee">
</a>

Your support helps keep the project maintained and motivates me to build more useful tools for Linux and terminal users.

**Other ways to support:**

* ⭐ Star the repository
* 🐛 Report bugs
* 💡 Suggest new features
* 📢 Share `chitr` with other Linux users

Thank you for supporting open-source! ❤️

If you found a bug, have an idea, or need help using `chitr`, you can use one of these options:

### 🐛 Bug Reports

Please open a GitHub Issue and include:

* Linux distribution
* `chitr` version
* File type
* Command you used
* Error message
* Relevant terminal output

### 💡 Feature Requests

Have an idea that could make `chitr` better?

Open a feature request on GitHub and describe:

* What you'd like to add
* Why it would be useful
* How you think it could work

### 💬 Community Support

For quick questions, discussions, and general help, join the Telegram community:

**Telegram:** <a href="https://t.me/chitr_bykiyoshi"> <img src="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpngimg.com%2Fuploads%2Ftelegram%2Ftelegram_PNG7.png&f=1&nofb=1&ipt=94caa1474e437b4614819b4876cf20492b83d2b541d1a248cd8f92ed2fb1b429" height="30" width="100" alt="telegram id">

---

# 📄 License

This project is licensed under the **MIT License**.

See the [`LICENSE`](LICENSE) file for details.

---

<div align="center">

### Made with ❤️ for terminal lovers.

**chitr — Just type it. We'll open it.**

</div>
