# 🖼️ chitr

**A smart terminal tool to open images, videos, and audio files — quickly and easily.**

`chitr` is a lightweight media opener for your terminal that automatically detects whether a file is an **image, video, or audio** — by reading its actual content, not just the extension — then opens it using the best available application.

If the preferred application isn't installed or fails to open the file, `chitr` automatically falls back to another compatible application.

**No guessing. No complicated configuration. Just open your media.**

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Platform: Linux | macOS](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-blue.svg)
![Shell: Bash | Zsh | Fish](https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh%20%7C%20Fish-4EAA25.svg)

---

## ✨ Features

* 🔍 **Automatic File Detection**
  Detects images, videos, and audio using the `file` command (real content, not just the extension) — falls back to extension matching only if `file` isn't available.

* 🖥️ **GUI & Terminal Support**
  Choose between graphical applications and terminal-based viewers/players, presented in a clean, colorful selection menu every time — no assumptions carried over from your last choice.

* 🔄 **Smart Fallback System**
  If one application fails, `chitr` automatically tries another compatible application. Known quirks (like `mpv`'s harmless EOF exit code, or `ffplay`'s multi-Ctrl+C hard-exit code) are recognized so a real stop is never mistaken for a crash.

* 🐚 **Bash, Zsh & Fish Support**
  `chitr` runs natively in all three shells — each with a dedicated, purpose-built version (not a compatibility shim), since the three shells differ enough (hooks, array semantics) that a single script can't cover all of them.

* 🍎 **macOS Support**
  Detects macOS automatically, prioritizes native apps (**Preview**, **QuickTime Player**), and uses Homebrew for installing anything else.

* ⌨️ **Shell Integration**
  With shell integration enabled, you can simply type a media filename and let `chitr` handle the rest. The explicit `chitr <file>` command always works too, regardless of shell hook conflicts.

* 📦 **One-Line Install**
  A single installer detects which shell(s) you actually have and downloads only the file(s) you need — nothing you won't use.

* 📋 **Application Manager**
  Use `--list` to see which supported applications are installed and which are missing, across all three media types.

* ⚡ **Lightweight & Fast**
  No heavy dependencies, no background services.

---
**Sample Preview**
---
<img width="500" height="330" alt="Screenshot_2026-09-05_19-40-17" src="https://github.com/user-attachments/assets/0e328620-7ac7-47b6-8d30-134dc1b7b40f" width="10" height="10" />

---
**Sample Direct Photo View**
---
<img width="500" height="600" alt="Screenshot_2026-09-05_19-46-59" src="https://github.com/user-attachments/assets/13d437d5-3c66-45e8-96ea-8cb9203326a1" height="10" width="10" />

---
**Sample Direct Video view**
---
<img width="500" height="400" alt="Web_Photo_Editor" src="https://github.com/user-attachments/assets/ce792a7f-2346-4d47-b389-1eb10be66084" />

---
**Sample Direct Audio view**
---
<img width="500" height="300" alt="Screenshot_2026-09-05_19-51-07" src="https://github.com/user-attachments/assets/8ac1295c-e96f-4f44-8fd1-c47d6cf508da" />

---



---
# 🚀 Installation

## Quick Install (recommended)

This single command detects which shell(s) are installed on your system (Bash, Zsh, and/or Fish) and downloads **only** the matching file(s) — not all three:

```bash
curl -fsSL https://raw.githubusercontent.com/kiyoshi-enjo/chitr/main/chitr/install.sh | bash
```

It will:
- Detect Bash / Zsh / Fish on your system
- Download only the relevant script(s) to your home directory
- Wire them into the correct shell config (`.bashrc`, `.zshrc`, or `config.fish`)
- Make them executable

Open a new terminal and run:

```bash
chitr --setup
```

This installs a solid default toolkit (`jp2a`, `chafa`, `cacaview` for images; `mpv` for video/audio).

---

## Manual Install (git clone)

If you'd rather inspect the code first or don't want to pipe `curl` into `bash`:

```bash
git clone https://github.com/kiyoshi-enjo/chitr.git
cd chitr
chmod +x install.sh
./install.sh
```

`install.sh` runs the same shell-detection logic locally instead of over the network — same result, no download step.

### Installing Git, if you don't have it

| Distro | Command |
|---|---|
| Ubuntu / Debian / Mint | `sudo apt install git -y` |
| Fedora / RHEL / Rocky / Alma | `sudo dnf install git -y` |
| Arch / Manjaro / EndeavourOS | `sudo pacman -Sy git` |
| openSUSE | `sudo zypper install git` |
| Alpine | `sudo apk add git` |
| macOS | `brew install git` |

---

## macOS Notes

macOS ships an old default Bash (3.2) that `chitr` can't run on. If you use Bash on Mac:

```bash
brew install bash
```

If you use Zsh (the default shell on modern macOS), no extra step is needed — `chitr`'s Zsh version works out of the box once installed.

🎉 **That's it! chitr is ready to use.**

---

## 📦 Usage

### Open a File

```bash
chitr photo.jpg
chitr video.mp4
chitr song.mp3
```

Or, with shell integration, just type the filename directly:

```bash
photo.jpg
video.mp4
song.mp3
```

`chitr` automatically determines the file type and shows a menu:

```
🖼  Image detected: photo.jpg

╭──────────────────────────────────╮
│  1) GUI  =  In App                │
│  2) CLI  =  In Trmnl              │
╰──────────────────────────────────╯
Choose [1/2]:
```

### Available Commands

```bash
chitr --setup
```
Install recommended default applications.

```bash
chitr --list
```
Show installed and missing applications, by category.

```bash
chitr --help
```
Show the help menu.

---

## ⌨️ Shell Integration

Once installed, you can open a media file directly by typing its filename — no `chitr` prefix needed:

```bash
$ photo.jpg
```

This works in **Bash, Zsh, and Fish**. A couple of notes depending on your shell:

- **Bash / Zsh:** if something else on your system (like the `command-not-found` package on Debian/Ubuntu/Kali) also hooks into unknown commands, `chitr` automatically re-asserts itself before every prompt, so this keeps working regardless of load order.
- **Fish:** typing a bare filename works, but fish will also print its own harmless "command not found" message afterward — this is a fish design limitation (its hook doesn't fully suppress the default message), not a chitr bug. It only affects the bare-filename shortcut.

If you ever run into any issue with the bare-filename shortcut in any shell, `chitr <file>` always works as a guaranteed fallback.

---

# 🛠️ Supported Applications

## 🖼️ Images

**GUI:** `feh` `geeqie` `eog` `gthumb` `nomacs` `gwenview` `qview` `shotwell` `xnviewmp` `gimp` *(+ `Preview` on macOS)*

**Terminal / CLI:** `jp2a` `chafa` `cacaview` `catimg` `img2sixel` `viu` `timg` `w3m`

## 🎬 Videos

**GUI:** `vlc` `mpv` `celluloid` `totem` `smplayer` `parole` `kaffeine` `mplayer` *(+ `QuickTime Player` on macOS)*

**Terminal / CLI:** `mpv` `mplayer` `vlc` *(rendered in-terminal via `tct`/`caca` output)*

## 🎵 Audio

**GUI:** `vlc` `audacious` `rhythmbox` `clementine` `lollypop` `elisa` `deadbeef` *(+ `QuickTime Player` on macOS)*

**Terminal / CLI:** `mpv` `mplayer` `mpg123` `ffplay`

Only apps that are actually installed are ever shown or used — everything else is skipped silently.

---

# 📋 Check Available Apps

```bash
chitr --list
```

Example:

```text
Image — GUI:
  ✔ feh
  ✘ geeqie
  ✔ gthumb
  ...

Image — CLI:
  ✔ jp2a
  ✔ chafa
  ✔ cacaview
  ...

Video — CLI:
  ✔ mpv
  ✘ mplayer
  ✘ vlc

Audio — CLI:
  ✔ mpv
  ✘ mpg123
  ✔ ffplay
```

---

# 🧠 How It Works

```text
                 ┌──────────────┐
                 │   chitr FILE │
                 └──────┬───────┘
                        │
                        ▼
               ┌─────────────────┐
               │ Detect File Type│
               │ (real MIME type)│
               └────────┬────────┘
                        │
          ┌─────────────┼─────────────┐
          ▼             ▼             ▼
       🖼️ Image       🎬 Video      🎵 Audio
          │             │             │
          ▼             ▼             ▼
      Find Apps      Find Apps      Find Apps
      (installed      (installed     (installed
       only)           only)          only)
          │             │             │
          └─────────────┼─────────────┘
                        ▼
              1 found → open directly
              2+ found → ask which one
              0 found → suggest install
                        │
                        ▼
                 App Fails?
                   /       \
                 No         Yes (real failure,
                 │           not a user stop)
                 ▼           │
                Done         ▼
                        Try next installed app
```

Each shell (Bash, Zsh, Fish) runs its own dedicated implementation of this flow — the logic is equivalent, but hooks, arrays, and syntax are native to each shell rather than emulated.

---

# 🔮 Coming Soon

* 🧩 Plugin system for new file types

* 🕘 Recently opened file history

* 🎨 Custom application priority

* 🧪 Better error reporting and diagnostics

---

# ☕ Support the Project

If **chitr** is useful to you and you'd like to support its development, you can buy me a coffee! ☕❤️

<a href="https://ko-fi.com/YOUR_USERNAME">
  <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Buy Me a Coffee">
</a>

Your support helps keep the project maintained and motivates me to build more useful tools for Linux, macOS, and terminal users.

**Other ways to support:**

* ⭐ Star the repository
* 🐛 Report bugs
* 💡 Suggest new features
* 📢 Share `chitr` with other terminal users

Thank you for supporting open-source! ❤️

If you found a bug, have an idea, or need help using `chitr`, you can use one of these options:

### 🐛 Bug Reports

Please open a GitHub Issue and include:

* OS and shell (e.g. "Ubuntu 24.04, Bash" or "macOS Sonoma, Zsh")
* `chitr` version
* File type
* Command you used
* Error message
* Relevant terminal output

### 💡 Feature Requests

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
