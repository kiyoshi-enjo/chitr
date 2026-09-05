#!/usr/bin/env fish
# chitr for fish — see chitr.sh (bash) / chitr.zsh for reference versions.
# INSTALL: save as ~/.config/fish/functions/chitr_init.fish is NOT needed;
# instead save this whole file as ~/.chitr.fish, then add to the END of
# ~/.config/fish/config.fish:
#   source ~/.chitr.fish
#
# NOTE: fish's `fish_command_not_found` hook does not fully suppress fish's
# own "command not found" message the way bash/zsh do — after chitr's menu
# runs, fish will still print a trailing squiggly-underline error. It's
# harmless (chitr already did its job by then), but it's a known fish
# limitation, not a chitr bug. `chitr <file>` never has this issue.

set -g _af (set_color -o green)
set -g _ad (set_color -o yellow)
set -g _ap (set_color -o red)
set -g _ak (set_color -o cyan)
set -g _aa (set_color -o magenta)
set -g _ai (set_color -o blue)
set -g _ag (set_color normal)

set -g _mac 0
if test (uname -s 2>/dev/null) = "Darwin"
    set -g _mac 1
end

function _mac_open
    set -l token $argv[1]
    set -l file $argv[2]
    switch $token
        case preview
            open -a "Preview" $file
        case quicktime
            open -a "QuickTime Player" $file
        case '*'
            $token $file
    end
end

function _is_avail
    set -l app $argv[1]
    switch $app
        case preview quicktime
            test $_mac -eq 1
            return
        case '*'
            command -v $app >/dev/null 2>&1
            return
    end
end

set -g _g feh geeqie eog gthumb nomacs gwenview qview shotwell xnviewmp gimp
set -g _f jp2a chafa cacaview catimg img2sixel viu timg w3m
set -g _i vlc mpv celluloid totem smplayer parole kaffeine mplayer
set -g _h mpv mplayer vlc
set -g _e vlc audacious rhythmbox clementine lollypop elisa deadbeef
set -g _d mpv mplayer mpg123 ffplay
set -g _m jp2a chafa cacaview mpv

if test $_mac -eq 1
    set -g _g preview $_g
    set -g _i quicktime $_i
    set -g _e quicktime $_e
end

set -g _y "jpg|jpeg|png|gif|bmp|webp|tiff|tif|svg|ico|heic"
set -g _z "mp4|mkv|avi|webm|mov|flv|wmv|m4v|mpg|mpeg|3gp"
set -g _x "mp3|wav|flac|ogg|m4a|aac|wma|opus|aiff|ape"

function _q
    set -l input $argv[1]
    if not test -f "$input"
        echo ""
        return 1
    end
    if command -v file >/dev/null 2>&1
        set -l mime (file --mime-type -b -- "$input" 2>/dev/null)
        switch $mime
            case 'image/*'
                echo "image"; return 0
            case 'video/*'
                echo "video"; return 0
            case 'audio/*'
                echo "audio"; return 0
            case '*'
                echo ""; return 1
        end
    end
    set -l ext (string split -r -m1 . -- "$input")[-1]
    set -l ext (string lower -- "$ext")
    if string match -qr "^($_y)\$" -- "$ext"
        echo "image"; return 0
    else if string match -qr "^($_z)\$" -- "$ext"
        echo "video"; return 0
    else if string match -qr "^($_x)\$" -- "$ext"
        echo "audio"; return 0
    end
    echo ""
    return 1
end

function _n
    if test $_mac -eq 1; and command -v brew >/dev/null 2>&1
        echo "brew"; return
    else if command -v apt >/dev/null 2>&1
        echo "apt"; return
    else if command -v dnf >/dev/null 2>&1
        echo "dnf"; return
    else if command -v yum >/dev/null 2>&1
        echo "yum"; return
    else if command -v pacman >/dev/null 2>&1
        echo "pacman"; return
    else if command -v zypper >/dev/null 2>&1
        echo "zypper"; return
    else if command -v apk >/dev/null 2>&1
        echo "apk"; return
    else if command -v brew >/dev/null 2>&1
        echo "brew"; return
    end
    echo ""
end

function _b
    switch $argv[1]
        case apt
            echo "apt install -y"
        case dnf
            echo "dnf install -y"
        case yum
            echo "yum install -y"
        case pacman
            echo "pacman -S --noconfirm"
        case zypper
            echo "zypper install -y"
        case apk
            echo "apk add"
        case brew
            echo "brew install"
        case '*'
            echo ""
    end
end

function _o
    set -l app $argv[1]
    set -l mgr $argv[2]
    switch $app
        case img2sixel
            if test "$mgr" = "pacman"
                echo "libsixel"
            else
                echo "libsixel-bin"
            end
        case cacaview
            if test "$mgr" = "pacman"
                echo "libcaca"
            else
                echo "caca-utils"
            end
        case ffplay
            echo "ffmpeg"
        case '*'
            echo "$app"
    end
end

function _v
    if test "$argv[1]" = "brew"
        echo ""
        return
    end
    if test (id -u) -ne 0
        echo "sudo "
    else
        echo ""
    end
end

function _ae
    echo -e "$_ak""chitr"$_ag" — quick image & video launcher (fish)"
end

function _an
    _ae
    echo ""
    echo "Usage:"
    echo "  chitr <file>      Open an image, video, or audio file (always works)"
    echo "  <file>            Same thing, typed directly"
    echo "  chitr --setup     Install the default apps"
    echo "  chitr --help      Show this help"
    echo "  chitr --list      Show installed vs missing viewers/players"
end

function _ah
    _ae
    echo ""
    set -l mgr (_n)
    set -l prefix (_b $mgr)
    set -l sudo_prefix (_v $mgr)
    if test -z "$mgr"
        echo -e "$_ap""Could not detect your package manager.$_ag"
        echo "Please install manually: $_m"
        return 1
    end
    set -l to_install
    for app in $_m
        if command -v $app >/dev/null 2>&1
            echo -e "$_af""✔ $app already installed$_ag"
        else
            set -l pkg (_o $app $mgr)
            echo -e "$_ad""✘ $app not found — will install '$pkg'$_ag"
            set -a to_install $pkg
        end
    end
    if test (count $to_install) -eq 0
        echo ""
        echo -e "$_af""All default apps are already installed. Nothing to do.$_ag"
        return 0
    end
    echo ""
    echo -e "$_ak""Running: $sudo_prefix$prefix $to_install$_ag"
    eval "$sudo_prefix$prefix $to_install"
end

function _c
    set -l label $argv[1]
    set -e argv[1]
    echo -e "$label:"
    for app in $argv
        if command -v $app >/dev/null 2>&1
            echo -e "  $_af""✔$_ag $app"
        else
            echo -e "  $_ap""✘$_ag $app"
        end
    end
end

function _s
    _ae
    echo ""
    _c "Image — GUI" $_g
    echo ""
    _c "Image — CLI" $_f
    echo ""
    _c "Video — GUI" $_i
    echo ""
    _c "Video — CLI" $_h
    echo ""
    _c "Audio — GUI" $_e
    echo ""
    _c "Audio — CLI" $_d
end

function _al
    set -l file $argv[1]
    set -l media $argv[2]
    set -l label icon
    switch $media
        case image
            set label "Image"; set icon "🖼"
        case video
            set label "Video"; set icon "🎬"
        case audio
            set label "Audio"; set icon "🎵"
    end
    echo -e "$_ak$icon  $label detected:$_ag $file"
    echo ""
    echo -e "$_aa""╭──────────────────────────────────╮$_ag"
    echo -e "$_aa""│$_ag  1) $_af""GUI$_ag  =  $_ai""In App$_ag         $_aa""│$_ag"
    echo -e "$_aa""│$_ag  2) $_af""CLI$_ag  =  $_ai""In Trmnl$_ag       $_aa""│$_ag"
    echo -e "$_aa""╰──────────────────────────────────╯$_ag"
    read -P "Choose [1/2]: " choice

    set -l gui_list cli_list
    switch $media
        case image
            set gui_list _g; set cli_list _f
        case video
            set gui_list _i; set cli_list _h
        case audio
            set gui_list _e; set cli_list _d
    end

    switch $choice
        case 1
            _p $gui_list $file gui $media
        case 2
            _p $cli_list $file cli $media
        case '*'
            echo -e "$_ad""Invalid choice.$_ag"
    end
end

function _ac
    set -l app $argv[1]
    set -l file $argv[2]
    set -l errfile (mktemp)
    _mac_open $app $file >$errfile 2>&1 &
    set -l pid $last_pid
    sleep 0.5
    if kill -0 $pid 2>/dev/null
        disown $pid 2>/dev/null
        rm -f $errfile
        return 0
    else
        wait $pid 2>/dev/null
        set -l st $status
        if test $st -ne 0
            echo -e "$_ad""  '$app' couldn't open this file:$_ag"
            tail -n 2 $errfile | sed 's/^/    /'
        end
        rm -f $errfile
        return $st
    end
end

function _j
    set -l app $argv[1]
    set -l file $argv[2]
    $app $file
    set -l st $status
    if test $st -ne 0 -a $st -lt 128
        echo -e "$_ad""  '$app' couldn't open this file (exit code $st).$_ag"
    end
    return $st
end

function _k
    set -l app $argv[1]
    set -l file $argv[2]
    switch $app
        case mpv
            $app --vo=tct $file
        case mplayer
            $app -vo caca $file
        case vlc
            if command -v cvlc >/dev/null 2>&1
                cvlc --vout caca --play-and-exit $file
            else
                $app --intf dummy --vout caca --play-and-exit $file
            end
        case '*'
            $app $file
    end
    set -l st $status
    if test "$app" = "mpv" -a $st -eq 4
        return 0
    end
    if test $st -ne 0 -a $st -lt 128
        echo -e "$_ad""  '$app' couldn't play this file in-terminal (exit code $st).$_ag"
    end
    return $st
end

function _l
    set -l app $argv[1]
    set -l file $argv[2]
    switch $app
        case mpv
            $app --no-video $file
        case mplayer
            $app -vo null $file
        case ffplay
            $app -nodisp -autoexit -loglevel error $file
        case '*'
            $app $file
    end
    set -l st $status
    if test "$app" = "mpv" -a $st -eq 4
        return 0
    end
    if test "$app" = "ffplay" -a $st -eq 123
        return 130
    end
    if test $st -ne 0 -a $st -lt 128
        echo -e "$_ad""  '$app' couldn't play this file (exit code $st).$_ag"
    end
    return $st
end

function _ab
    set -l app $argv[1]
    set -l file $argv[2]
    set -l interface $argv[3]
    set -l media $argv[4]
    set -l st
    if test "$interface" = "gui"
        _ac $app $file
        set st $status
    else if test "$media" = "video"
        _k $app $file
        set st $status
    else if test "$media" = "audio"
        _l $app $file
        set st $status
    else
        _j $app $file
        set st $status
    end
    return $st
end

function _p
    set -l list_name $argv[1]
    set -l file $argv[2]
    set -l interface $argv[3]
    set -l media $argv[4]
    set -l apps $$list_name
    set -l installed
    for app in $apps
        if _is_avail $app
            set -a installed $app
        end
    end

    if test (count $installed) -eq 0
        set -l mgr_name (_n)
        set -l mgr (_b $mgr_name)
        set -l sudo_prefix (_v $mgr_name)
        set -l pkg (_o $apps[1] $mgr_name)
        echo -e "$_ap""No supported app is installed for this.$_ag"
        echo "Options from this list:"
        for a in $apps
            echo "   $a"
        end
        echo ""
        if test -n "$mgr"
            echo -e "$_ad""Suggested install (your distro):$_ag"
            echo "   $sudo_prefix$mgr $pkg"
        else
            echo -e "$_ad""Could not detect your package manager.$_ag"
            echo "Install '$pkg' manually using your distro's package tool."
        end
        return 1
    end

    set -l chosen ""
    if test (count $installed) -eq 1
        set chosen $installed[1]
    else
        echo -e "$_aa""✨ Multiple apps found — which one do you want to use?$_ag"
        set -l i 1
        for app in $installed
            echo -e "  $i) $_af$app$_ag"
            set i (math $i + 1)
        end
        read -P "Choose [1-"(count $installed)"]: " pick
        if string match -qr '^[0-9]+$' -- "$pick"; and test $pick -ge 1 -a $pick -le (count $installed)
            set chosen $installed[$pick]
        else
            echo -e "$_ad""Invalid choice.$_ag"
            return 1
        end
    end

    echo -e "$_af""→ Opening with '$chosen'...$_ag"
    _ab $chosen $file $interface $media
    set -l st $status
    if test $st -eq 0
        return 0
    end
    if test $st -ge 128
        echo -e "$_ad""Stopped.$_ag"
        return 0
    end
    echo -e "$_ak""  '$chosen' failed. Trying remaining installed options...$_ag"
    for app in $installed
        if test "$app" = "$chosen"
            continue
        end
        echo -e "$_af""→ Trying '$app'...$_ag"
        _ab $app $file $interface $media
        set st $status
        if test $st -eq 0
            return 0
        end
        if test $st -ge 128
            echo -e "$_ad""Stopped.$_ag"
            return 0
        end
        echo -e "$_ak""  Falling back to next available option...$_ag"
    end
    echo -e "$_ap""All installed options failed to open this file.$_ag"
    echo "The file may be corrupted or in an unsupported format."
    return 1
end

function _am
    set -l input $argv[1]
    if test -z "$input"
        _an
        return 1
    end
    if not test -e "$input"
        echo -e "$_ap""chitr: '$input': no such file$_ag"
        return 1
    end
    set -l media (_q $input)
    if test "$media" = "image" -o "$media" = "video" -o "$media" = "audio"
        _al $input $media
    else
        echo -e "$_ap""chitr: '$input': not a recognized image, video, or audio file$_ag"
        return 1
    end
end

function chitr
    switch $argv[1]
        case --help -h
            _an
        case --list -l
            _s
        case --setup -s
            _ah
        case ''
            _an
        case '*'
            _am $argv[1]
    end
end

function fish_command_not_found
    set -l input $argv[1]
    if test -e "$input"
        set -l media (_q $input)
        if test "$media" = "image" -o "$media" = "video" -o "$media" = "audio"
            _al $input $media
            return 0
        end
    end
    echo -e "$_ap""fish: command not found: $input$_ag"
end
