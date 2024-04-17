### FISH-CONFIG OF USER DAVID

## Remove welcome message
set fish_greeting

## Set nvim as default editor
export EDITOR="/usr/bin/nvim"

## Run neofetch if session is interactive
if status --is-interactive
   #neofetch
end
