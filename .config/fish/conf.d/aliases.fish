# Auto-generated from ~/.config/shell/.aliases
# Run ~/.config/fish/convert_shell_config.fish to regenerate

# Useful aliases

alias ls='eza -al --color=always --group-directories-first --icons=auto'
alias la='eza -a --color=always --group-directories-first --icons=auto'
alias ll='eza -l --color=always --group-directories-first --icons=auto'
alias lt='eza -aT --color=always --group-directories-first --icons=auto'
alias l.='eza -d .* --color=always --group-directories-first --icons=auto'

alias cat='bat --style=plain'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias ff='fastfetch'
alias hw='hwinfo --short'
alias wget='wget -c'
alias grep='grep --color=auto'

alias tarnow='tar -acf'
alias untar='tar -zxvf'

alias jctl="journalctl -p 3 -xb"
alias failed='systemctl --failed'
alias userfailed='systemctl --user --failed'
alias fixaudio='systemctl --user restart pipewire.socket pipewire wireplumber'

alias ac='$EDITOR ~/.config/shell/.aliases'
alias ec='$EDITOR ~/.config/shell/.env_vars'
alias docker='sudo docker'
alias vencord-install='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'

alias vpnhomenetwork='sudo wg-quick up homenetwork'

alias pacman='sudo pacman'
alias rmpaclock="sudo rm /var/lib/pacman/db.lck"
alias rmpkg="sudo pacman -Rdd"
# Hand-written: fish cannot parse a bare `$` before a closing double quote,
# so the anchor lives in single quotes here instead.
alias gitpkg="pacman -Qq | grep -c '\\-git\$'"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

alias java-g='archlinux-java get'
alias java-s='archlinux-java status'
alias java-set8='sudo archlinux-java set java-8-openjdk'
alias java-set11='sudo archlinux-java set java-11-openjdk'
alias java-set17='sudo archlinux-java set java-17-openjdk'
alias java-set21='sudo archlinux-java set java-21-openjdk'

alias plasmarestart='systemctl --user restart plasma-plasmashell'
alias fixkwin='qdbus org.kde.KWin /KWin reconfigure'
alias mailspring='mailspring --password-store="kwallet5"'

alias getgpu='optimus-manager --print-mode'
alias integratedgpu='optimus-manager --switch integrated --no-confirm'
alias nvidiagpu='optimus-manager --switch nvidia --no-confirm'
alias hybridgpu='optimus-manager --switch hybrid --no-confirm'

alias wlan-monitor='sudo airmon-ng start wlo1 && sudo airmon-ng check kill'
alias wlan-managed='sudo airmon-ng stop wlo1mon && sudo systemctl restart NetworkManager'
alias airodump='sudo airodump-ng wlo1mon'
alias clearshakes='sudo rm -i ~/Documents/Aircrack/Handshakes/*'
alias deauth='sudo aireplay-ng wlo1mon --deauth'

# Skipped complex alias: cshack
