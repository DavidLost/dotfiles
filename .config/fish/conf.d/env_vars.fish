# Auto-generated from ~/.config/shell/.env_vars
# Run ~/.config/fish/convert_shell_config.fish to regenerate

# Set language vars to english
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Default ditor
set -gx EDITOR "nvim"

# Multithreaded make
set -gx MAKEFLAGS (nproc 2>/dev/null || echo 4)

# Rust cargo stuff
# source "$HOME/.cargo/env"
# export CARGO_INCREMENTAL=1                      # Enable cargo incremental compilation
# export CARGO_TARGET_DIR="$HOME/.cargo/cache"    # Set the cargo target directory for incremental compilation

# User-installed command-line tools
fish_add_path $HOME/.local/bin

# ROCm paths
fish_add_path /opt/rocm/bin
set -gx LD_LIBRARY_PATH /opt/rocm/lib

# Launch steam always with 1.25 scaling (doesn't seem to work...)
set -gx STEAM_FORCE_DESKTOPUI_SCALING 1.25

# Ensure multithreaded builds for cmake and ninja
set -gx CMAKE_BUILD_PARALLEL_LEVEL (nproc 2>/dev/null || echo 4)
set -gx NINJAJOBS (nproc 2>/dev/null || echo 4)
