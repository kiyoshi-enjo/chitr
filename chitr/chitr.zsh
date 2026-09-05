#!/usr/bin/env zsh
# chitr for zsh — see chitr.sh (bash version) for the canonical reference.
# INSTALL: save as ~/.chitr.zsh, then add to the END of ~/.zshrc:
#   source ~/.chitr.zsh

_af='\033[1;32m'
_ad='\033[1;33m'
_ap='\033[1;31m'
_ak='\033[1;36m'
_aa='\033[1;35m'
_ai='\033[1;34m'
_aj='\033[1m'
_ao='\033[2m'
_ag='\033[0m'

_mac=0
[[ "$(uname -s 2>/dev/null)" == "Darwin" ]] && _mac=1

_mac_open() {
    local token="$1" file="$2"
    case "$token" in
        preview) open -a "Preview" "$file" ;;
        quicktime) open -a "QuickTime Player" "$file" ;;
        *) "$token" "$file" ;;
    esac
}

_is_avail() {
    local app="$1"
    case "$app" in
        preview|quicktime) (( _mac )) && return 0 || return 1 ;;
        *) command -v "$app" &>/dev/null ;;
    esac
}

_g=("feh" "geeqie" "eog" "gthumb" "nomacs" "gwenview" "qview" "shotwell" "xnviewmp" "gimp")
_f=("jp2a" "chafa" "cacaview" "catimg" "img2sixel" "viu" "timg" "w3m")
_i=("vlc" "mpv" "celluloid" "totem" "smplayer" "parole" "kaffeine" "mplayer")
_h=("mpv" "mplayer" "vlc")
_e=("vlc" "audacious" "rhythmbox" "clementine" "lollypop" "elisa" "deadbeef")
_d=("mpv" "mplayer" "mpg123" "ffplay")
_m=("jp2a" "chafa" "cacaview" "mpv")

if (( _mac )); then
    _g=("preview" "${_g[@]}")
    _i=("quicktime" "${_i[@]}")
    _e=("quicktime" "${_e[@]}")
fi

_y="jpg|jpeg|png|gif|bmp|webp|tiff|tif|svg|ico|heic"
_z="mp4|mkv|avi|webm|mov|flv|wmv|m4v|mpg|mpeg|3gp"
_x="mp3|wav|flac|ogg|m4a|aac|wma|opus|aiff|ape"

_q() {
    local input="$1"
    [[ -f "$input" ]] || { echo ""; return 1; }
    if command -v file &>/dev/null; then
        local mime
        mime="$(file --mime-type -b -- "$input" 2>/dev/null)"
        case "$mime" in
            image/*) echo "image"; return 0 ;;
            video/*) echo "video"; return 0 ;;
            audio/*) echo "audio"; return 0 ;;
            *) echo ""; return 1 ;;
        esac
    fi
    local ext="${input##*.}"
    ext="${ext:l}"
    if [[ "$ext" =~ ^($_y)$ ]]; then echo "image"; return 0
    elif [[ "$ext" =~ ^($_z)$ ]]; then echo "video"; return 0
    elif [[ "$ext" =~ ^($_x)$ ]]; then echo "audio"; return 0
    fi
    echo ""; return 1
}

_n() {
    if (( _mac )) && command -v brew &>/dev/null; then echo "brew"
    elif command -v apt &>/dev/null; then echo "apt"
    elif command -v dnf &>/dev/null; then echo "dnf"
    elif command -v yum &>/dev/null; then echo "yum"
    elif command -v pacman &>/dev/null; then echo "pacman"
    elif command -v zypper &>/dev/null; then echo "zypper"
    elif command -v apk &>/dev/null; then echo "apk"
    elif command -v brew &>/dev/null; then echo "brew"
    else echo ""
    fi
}

_b() {
    case "$1" in
        apt) echo "apt install -y" ;;
        dnf) echo "dnf install -y" ;;
        yum) echo "yum install -y" ;;
        pacman) echo "pacman -S --noconfirm" ;;
        zypper) echo "zypper install -y" ;;
        apk) echo "apk add" ;;
        brew) echo "brew install" ;;
        *) echo "" ;;
    esac
}

_o() {
    local app="$1" mgr="$2"
    case "$app" in
        img2sixel) [[ "$mgr" == "pacman" ]] && echo "libsixel" || echo "libsixel-bin" ;;
        cacaview) [[ "$mgr" == "pacman" ]] && echo "libcaca" || echo "caca-utils" ;;
        ffplay) echo "ffmpeg" ;;
        *) echo "$app" ;;
    esac
}

_v() {
    [[ "$1" == "brew" ]] && { echo ""; return; }
    [[ $EUID -ne 0 ]] && echo "sudo " || echo ""
}

_ae() {
    echo -e "${_ak}${_aj}chitr${_ag} — quick image & video launcher (zsh)"
}

_an() {
    _ae
    echo ""
    echo "Usage:"
    echo "  chitr <file>      Open an image, video, or audio file"
    echo "  <file>            Same thing, typed directly"
    echo "  chitr --setup     Install the default apps"
    echo "  chitr --help      Show this help"
    echo "  chitr --list      Show installed vs missing viewers/players"
}

_ah() {
    _ae
    echo ""
    local mgr prefix sudo_prefix
    mgr="$(_n)"
    prefix="$(_b "$mgr")"
    sudo_prefix="$(_v "$mgr")"
    if [[ -z "$mgr" ]]; then
        echo -e "${_ap}Could not detect your package manager.${_ag}"
        echo "Please install manually: ${_m[*]}"
        return 1
    fi
    local -a to_install
    local app
    for app in "${_m[@]}"; do
        if command -v "$app" &>/dev/null; then
            echo -e "${_af}✔ $app already installed${_ag}"
        else
            local pkg
            pkg="$(_o "$app" "$mgr")"
            echo -e "${_ad}✘ $app not found — will install '$pkg'${_ag}"
            to_install+=("$pkg")
        fi
    done
    if [[ ${#to_install[@]} -eq 0 ]]; then
        echo ""
        echo -e "${_af}All default apps are already installed. Nothing to do.${_ag}"
        return 0
    fi
    echo ""
    echo -e "${_ak}Running: ${sudo_prefix}${prefix} ${to_install[*]}${_ag}"
    eval "${sudo_prefix}${prefix} ${to_install[*]}"
}

_c() {
    local label="$1"; shift
    echo -e "${_aj}$label:${_ag}"
    local app
    for app in "$@"; do
        if command -v "$app" &>/dev/null; then
            echo -e "  ${_af}✔${_ag} $app"
        else
            echo -e "  ${_ap}✘${_ag} $app"
        fi
    done
}

_s() {
    _ae
    echo ""
    _c "Image — GUI" "${_g[@]}"
    echo ""
    _c "Image — CLI" "${_f[@]}"
    echo ""
    _c "Video — GUI" "${_i[@]}"
    echo ""
    _c "Video — CLI" "${_h[@]}"
    echo ""
    _c "Audio — GUI" "${_e[@]}"
    echo ""
    _c "Audio — CLI" "${_d[@]}"
}

_al() {
    local file="$1" media="$2"
    local label icon
    case "$media" in
        image) label="Image"; icon="🖼" ;;
        video) label="Video"; icon="🎬" ;;
        audio) label="Audio"; icon="🎵" ;;
    esac
    echo -e "${_ak}${icon}  ${label} detected:${_ag} $file"
    echo ""
    echo -e "${_aa}╭──────────────────────────────────╮${_ag}"
    echo -e "${_aa}│${_ag}  ${_aj}${_ad}1${_ag}) ${_af}GUI${_ag}  ${_ao}=${_ag}  ${_ai}In App${_ag}         ${_aa}│${_ag}"
    echo -e "${_aa}│${_ag}  ${_aj}${_ad}2${_ag}) ${_af}CLI${_ag}  ${_ao}=${_ag}  ${_ai}In Trmnl${_ag}       ${_aa}│${_ag}"
    echo -e "${_aa}╰──────────────────────────────────╯${_ag}"
    local choice
    read "choice?$(echo -e "${_ak}Choose [1/2]: ${_ag}")"
    local gui_list cli_list
    case "$media" in
        image) gui_list="_g"; cli_list="_f" ;;
        video) gui_list="_i"; cli_list="_h" ;;
        audio) gui_list="_e"; cli_list="_d" ;;
    esac
    case "$choice" in
        1) _p "$gui_list" "$file" "gui" "$media" ;;
        2) _p "$cli_list" "$file" "cli" "$media" ;;
        *) echo -e "${_ad}Invalid choice.${_ag}" ;;
    esac
}

_ac() {
    local app="$1" file="$2"
    local errfile
    errfile="$(mktemp)"
    _mac_open "$app" "$file" &>"$errfile" &
    local pid=$!
    sleep 0.5
    if kill -0 "$pid" 2>/dev/null; then
        disown %"$pid" 2>/dev/null
        rm -f "$errfile"
        return 0
    else
        wait "$pid" 2>/dev/null
        local st=$?
        if [[ $st -ne 0 ]]; then
            echo -e "${_ad}  '$app' couldn't open this file:${_ag}"
            tail -n 2 "$errfile" | sed 's/^/    /'
        fi
        rm -f "$errfile"
        return $st
    fi
}

_u=0
_w() {
    _u=0
    trap '_u=1' INT
    setopt NO_MONITOR 2>/dev/null
    "$@"
    local st=$?
    setopt MONITOR 2>/dev/null
    trap - INT
    return $st
}

_j() {
    local app="$1" file="$2"
    _w "$app" "$file"
    local st=$?
    if [[ $_u -eq 1 ]]; then return 130; fi
    [[ $st -ne 0 && $st -lt 128 ]] && echo -e "${_ad}  '$app' couldn't open this file (exit code $st).${_ag}"
    return $st
}

_k() {
    local app="$1" file="$2"
    case "$app" in
        mpv) _w "$app" --vo=tct "$file" ;;
        mplayer) _w "$app" -vo caca "$file" ;;
        vlc)
            if command -v cvlc &>/dev/null; then
                _w cvlc --vout caca --play-and-exit "$file"
            else
                _w "$app" --intf dummy --vout caca --play-and-exit "$file"
            fi
            ;;
        *) _w "$app" "$file" ;;
    esac
    local st=$?
    if [[ $_u -eq 1 ]]; then return 130; fi
    if [[ "$app" == "mpv" && $st -eq 4 ]]; then return 0; fi
    [[ $st -ne 0 && $st -lt 128 ]] && echo -e "${_ad}  '$app' couldn't play this file in-terminal (exit code $st).${_ag}"
    return $st
}

_l() {
    local app="$1" file="$2"
    case "$app" in
        mpv) _w "$app" --no-video "$file" ;;
        mplayer) _w "$app" -vo null "$file" ;;
        ffplay) _w "$app" -nodisp -autoexit -loglevel error "$file" ;;
        *) _w "$app" "$file" ;;
    esac
    local st=$?
    if [[ $_u -eq 1 ]]; then return 130; fi
    if [[ "$app" == "mpv" && $st -eq 4 ]]; then return 0; fi
    if [[ "$app" == "ffplay" && $st -eq 123 ]]; then return 130; fi
    [[ $st -ne 0 && $st -lt 128 ]] && echo -e "${_ad}  '$app' couldn't play this file (exit code $st).${_ag}"
    return $st
}

_ab() {
    local app="$1" file="$2" interface="$3" media="$4"
    local st
    if [[ "$interface" == "gui" ]]; then
        _ac "$app" "$file"
        st=$?
    elif [[ "$media" == "video" ]]; then
        _k "$app" "$file"; st=$?
    elif [[ "$media" == "audio" ]]; then
        _l "$app" "$file"; st=$?
    else
        _j "$app" "$file"; st=$?
    fi
    return $st
}

_p() {
    local list_name="$1" file="$2" interface="$3" media="$4"
    local -a installed
    local app
    for app in ${(P)list_name[@]}; do
        _is_avail "$app" && installed+=("$app")
    done

    if [[ ${#installed[@]} -eq 0 ]]; then
        local mgr_name mgr sudo_prefix pkg first
        mgr_name="$(_n)"
        mgr="$(_b "$mgr_name")"
        sudo_prefix="$(_v "$mgr_name")"
        first="${${(P)list_name}[1]}"
        pkg="$(_o "$first" "$mgr_name")"
        echo -e "${_ap}No supported app is installed for this.${_ag}"
        echo "Options from this list:"
        printf '   %s\n' ${(P)list_name[@]}
        echo ""
        if [[ -n "$mgr" ]]; then
            echo -e "${_ad}Suggested install (your distro):${_ag}"
            echo "   ${sudo_prefix}${mgr} ${pkg}"
        else
            echo -e "${_ad}Could not detect your package manager.${_ag}"
            echo "Install '${pkg}' manually using your distro's package tool."
        fi
        return 1
    fi

    local chosen=""
    if [[ ${#installed[@]} -eq 1 ]]; then
        chosen="${installed[1]}"
    else
        echo -e "${_aa}✨ Multiple apps found — which one do you want to use?${_ag}"
        local i=1
        for app in "${installed[@]}"; do
            echo -e "  ${_aj}${_ad}$i${_ag}) ${_af}$app${_ag}"
            ((i++))
        done
        local pick
        read "pick?$(echo -e "${_ak}Choose [1-${#installed[@]}]: ${_ag}")"
        if [[ "$pick" =~ ^[0-9]+$ ]] && (( pick >= 1 && pick <= ${#installed[@]} )); then
            chosen="${installed[$pick]}"
        else
            echo -e "${_ad}Invalid choice.${_ag}"
            return 1
        fi
    fi

    echo -e "${_af}→ Opening with '$chosen'...${_ag}"
    _ab "$chosen" "$file" "$interface" "$media"
    local st=$?
    [[ $st -eq 0 ]] && return 0
    if [[ $st -ge 128 ]]; then
        echo -e "${_ad}Stopped.${_ag}"
        return 0
    fi
    echo -e "${_ak}  '$chosen' failed. Trying remaining installed options...${_ag}"
    for app in "${installed[@]}"; do
        [[ "$app" == "$chosen" ]] && continue
        echo -e "${_af}→ Trying '$app'...${_ag}"
        _ab "$app" "$file" "$interface" "$media"
        st=$?
        [[ $st -eq 0 ]] && return 0
        if [[ $st -ge 128 ]]; then
            echo -e "${_ad}Stopped.${_ag}"
            return 0
        fi
        echo -e "${_ak}  Falling back to next available option...${_ag}"
    done
    echo -e "${_ap}All installed options failed to open this file.${_ag}"
    echo "The file may be corrupted or in an unsupported format."
    return 1
}

_am() {
    local input="$1"
    if [[ -z "$input" ]]; then _an; return 1; fi
    if [[ ! -e "$input" ]]; then
        echo -e "${_ap}chitr: '$input': no such file${_ag}"
        return 1
    fi
    local media
    media="$(_q "$input")"
    if [[ "$media" == "image" || "$media" == "video" || "$media" == "audio" ]]; then
        _al "$input" "$media"
    else
        echo -e "${_ap}chitr: '$input': not a recognized image, video, or audio file${_ag}"
        return 1
    fi
}

chitr() {
    case "$1" in
        --help|-h) _an ;;
        --list|-l) _s ;;
        --setup|-s) _ah ;;
        "") _an ;;
        *) _am "$1" ;;
    esac
}

_a() {
    local input="$1"
    if [[ -e "$input" ]]; then
        local media
        media="$(_q "$input")"
        if [[ "$media" == "image" || "$media" == "video" || "$media" == "audio" ]]; then
            _al "$input" "$media"
            return 0
        fi
    fi
    echo -e "${_ap}zsh: command not found: $input${_ag}"
    return 127
}

_t() {
    if ! whence -f command_not_found_handler 2>/dev/null | grep -q "_a "; then
        command_not_found_handler() { _a "$@"; }
    fi
}
_t
if [[ -z "${precmd_functions[(r)_t]}" ]]; then
    precmd_functions+=(_t)
fi
