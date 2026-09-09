#!/usr/bin/env fish
# Script to convert bash shell config to fish syntax
# Run this script whenever you update .env_vars or .aliases

set SHELL_DIR ~/.config/shell
set FISH_CONF_DIR ~/.config/fish/conf.d

echo "Converting shell configuration to fish syntax..."

# Convert environment variables
if test -f $SHELL_DIR/.env_vars
    echo "# Auto-generated from ~/.config/shell/.env_vars" > $FISH_CONF_DIR/env_vars.fish
    echo "# Run ~/.config/fish/convert_shell_config.fish to regenerate" >> $FISH_CONF_DIR/env_vars.fish
    echo "" >> $FISH_CONF_DIR/env_vars.fish
    
    # Parse each line
    for line in (cat $SHELL_DIR/.env_vars)
        # Skip comments and empty lines
        if string match -qr '^\s*#' $line; or test -z "$line"
            echo $line >> $FISH_CONF_DIR/env_vars.fish
            continue
        end
        
        # Convert export statements
        if string match -qr '^export ' $line
            set cleaned (string replace 'export ' '' $line)
            set var_name (string split -m 1 '=' $cleaned)[1]
            set var_value (string split -m 1 '=' $cleaned)[2]
            
            # Remove quotes
            set var_value (string trim -c '"' -c "'" $var_value)
            
            # Handle special cases
            switch $var_name
                case 'PATH'
                    # Extract the actual path from $PATH:/some/path constructs
                    set path_to_add (string replace '$PATH:' '' $var_value)
                    echo "fish_add_path $path_to_add" >> $FISH_CONF_DIR/env_vars.fish
                case '*'
                    # Check if value contains command substitution
                    if string match -qr '\$\(' $var_value
                        # Handle command substitutions
                        if string match -q '*$(nproc)*' $var_value
                            # Substitute in place so surrounding text survives,
                            # e.g. -j$(nproc) must stay -j16 and not become 16.
                            # Keep the $ prefix: fish only treats (cmd) as a
                            # substitution when unquoted, but $(cmd) works both
                            # inside and outside the double quotes kept above.
                            set fish_value (string replace -a '$(nproc)' '$(nproc 2>/dev/null || echo 4)' $var_value)
                            echo "set -gx $var_name $fish_value" >> $FISH_CONF_DIR/env_vars.fish
                        else
                            echo "set -gx $var_name $var_value" >> $FISH_CONF_DIR/env_vars.fish
                        end
                    else
                        echo "set -gx $var_name $var_value" >> $FISH_CONF_DIR/env_vars.fish
                    end
            end
        else if string match -qr '^\s*$' $line
            echo "" >> $FISH_CONF_DIR/env_vars.fish
        else
            # Keep other lines as comments
            echo "# $line" >> $FISH_CONF_DIR/env_vars.fish
        end
    end
    
    echo "✓ Created $FISH_CONF_DIR/env_vars.fish"
end

# Convert aliases
if test -f $SHELL_DIR/.aliases
    echo "# Auto-generated from ~/.config/shell/.aliases" > $FISH_CONF_DIR/aliases.fish
    echo "# Run ~/.config/fish/convert_shell_config.fish to regenerate" >> $FISH_CONF_DIR/aliases.fish
    echo "" >> $FISH_CONF_DIR/aliases.fish
    
    for line in (cat $SHELL_DIR/.aliases)
        # Skip comments and empty lines, but preserve section comments
        if string match -qr '^\s*##' $line
            echo (string replace '##' '#' $line) >> $FISH_CONF_DIR/aliases.fish
            continue
        else if string match -qr '^\s*#' $line
            continue
        else if test -z "$line"
            echo "" >> $FISH_CONF_DIR/aliases.fish
            continue
        end
        
        # Convert alias statements
        if string match -qr '^alias ' $line
            # Remove inline comments first
            set clean_line (string split '#' $line)[1]
            set cleaned (string replace 'alias ' '' $clean_line)
            set alias_name (string split -m 1 '=' $cleaned)[1]
            set alias_value (string split -m 1 '=' $cleaned)[2]
            
            # Trim whitespace and leading/trailing quotes as needed
            set alias_value (string trim $alias_value)
            
            # Skip problematic aliases with complex bash syntax (subshells with background jobs)
            if string match -qr '\(.*\).*&' $alias_value
                echo "# Skipped complex alias: $alias_name" >> $FISH_CONF_DIR/aliases.fish
                continue
            end
            
            # Write the alias exactly as it is (fish handles both single and double quotes)
            echo "alias $alias_name=$alias_value" >> $FISH_CONF_DIR/aliases.fish
        end
    end
    
    echo "✓ Created $FISH_CONF_DIR/aliases.fish"
end

echo ""
echo "Conversion complete! Reload fish config with: source ~/.config/fish/config.fish"
