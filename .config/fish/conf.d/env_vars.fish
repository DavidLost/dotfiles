# Auto-generated from ~/.config/shell/.env_vars
# Run ~/.config/fish/convert_shell_config.fish to regenerate

# Set language vars to english
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Nvidia
set -gx __NV_PRIME_RENDER_OFFLOAD 1
set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
set -gx __VK_LAYER_NV_optimus NVIDIA_only

# Multithreaded make
set -gx MAKEFLAGS "-j$(nproc 2>/dev/null || echo 4)"

# Rust cargo stuff
# source "$HOME/.cargo/env"
# export CARGO_INCREMENTAL=1                      # Enable cargo incremental compilation
# export CARGO_TARGET_DIR="$HOME/.cargo/cache"    # Set the cargo target directory for incremental compilation

# Set default editor
set -gx EDITOR "nvim"

# User-installed command-line tools
fish_add_path $HOME/.local/bin

# ROCm paths
fish_add_path /opt/rocm/bin
set -gx LD_LIBRARY_PATH /opt/rocm/lib

# Launch steam always with 1.25 scaling (doesn't seem to work...)
set -gx STEAM_FORCE_DESKTOPUI_SCALING 1.25

# Ensure multithreaded builds for cmake and ninja
set -gx CMAKE_BUILD_PARALLEL_LEVEL $(nproc 2>/dev/null || echo 4)
set -gx NINJAJOBS $(nproc 2>/dev/null || echo 4)

# NVM Config
# Hand-written: the converter cannot translate the bash parameter expansion
# below, and nvm.sh is a bash function that fish cannot source at all. Only
# NVM_DIR is exported; use nvm.fish or bass to drive nvm from fish.
if test -n "$XDG_CONFIG_HOME"
    set -gx NVM_DIR "$XDG_CONFIG_HOME/nvm"
else
    set -gx NVM_DIR "$HOME/.nvm"
end
