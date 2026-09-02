#!/bin/bash

# Directory where the .desktop files are located
DESKTOP_DIR="$HOME/.local/share/applications"

# The environment variable to add
ENV_VAR="STEAM_FORCE_DESKTOPUI_SCALING=1.25"

# Avoid iterating over a literal glob when no desktop files exist.
shopt -s nullglob

# Loop through each .desktop file in the directory
for FILE in "$DESKTOP_DIR"/*.desktop; do
    # Check if the .desktop file is associated with Steam
    if grep -q "^Exec=.*steam" "$FILE"; then
        if grep -q "^Exec=env $ENV_VAR " "$FILE"; then
            echo "Already scaled: $(basename "$FILE")"
            continue
        fi

        echo "Updating Steam game .desktop file: $(basename "$FILE")"
        sed -i "/^Exec=/ s#Exec=#Exec=env $ENV_VAR #" "$FILE"
    fi
done