## Useful aliases
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles

# Managing packages
alias update='sudo apt-get update -y && sudo apt-get upgrade -y'
alias updatesystem='update && sudo apt-get dist-upgrade -y'
alias instal='sudo apt-get install -y'

# Common use
alias docker='sudo docker'
alias vim='nvim'
alias fishconf='vim ~/.config/fish/config.fish'
alias aliasconf='vim ~/.config/fish/conf.d/alias.fish'
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cdDockerVolumes='cd /var/lib/docker/volumes'
alias cdtrash='cd ~/.local/share/Trash/files'
alias printtrash='ls ~/.local/share/Trash/files'
alias deletetrash='sudo rm -rv ~/.local/share/Trash/files && sudo mkdir ~/.local/share/Trash/files'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias please='sudo'
alias changejava='sudo update-alternatives --config java'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
