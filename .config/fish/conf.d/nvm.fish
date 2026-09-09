# Hand-written fish counterpart to the NVM block in ~/.config/shell/.env_vars.
# The converter cannot translate it: bash's ${VAR-} expansion is not fish
# syntax, and nvm.sh is a bash function fish cannot source at all. Only
# NVM_DIR is exported here - use nvm.fish or bass to drive nvm from fish.

if test -n "$XDG_CONFIG_HOME"
    set -gx NVM_DIR "$XDG_CONFIG_HOME/nvm"
else
    set -gx NVM_DIR "$HOME/.nvm"
end
