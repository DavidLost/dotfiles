#!/usr/bin/env fish
# Convert the shell-agnostic config in ~/.config/shell into fish syntax.
# Run this whenever you edit .env_vars or .aliases.
#
# Every definition is checked before it is written, so the generated files
# always source cleanly. Anything fish cannot parse is written out commented,
# with the reason, and reported at the end.
#
# The generated files are overwritten on every run - never hand-edit them.
# Fish code that has no counterpart in the shared config (see conf.d/nvm.fish)
# belongs in its own conf.d file instead.

set -g SHELL_DIR ~/.config/shell
set -g FISH_CONF_DIR ~/.config/fish/conf.d
set -g skipped 0

# --- helpers ---------------------------------------------------------------

# Comment lines and blank lines carry over to the generated file untouched.
function __csc_is_comment --argument-names line
    string match -qr '^\s*(#|$)' -- $line
end

# Strip one layer of balanced surrounding quotes.
function __csc_unquote --argument-names value
    set -l m (string match -r '^(["\'])(.*)\1$' -- $value)
    if test (count $m) -gt 0
        printf '%s\n' $m[3]
    else
        printf '%s\n' $value
    end
end

# Wrap a string in fish single quotes so one round of parsing reproduces it.
function __csc_squote --argument-names value
    set -l e (string replace -a -- '\\' '\\\\' $value)
    set e (string replace -a -- "'" "\\'" $e)
    printf "'%s'\n" $e
end

# Does the snippet parse as fish? -n parses without running anything.
function __csc_parses --argument-names code
    fish -n -c $code 2>/dev/null
end

# `alias` re-parses the body when it builds the function, which -n on the
# alias line alone never reaches. Define it in a throwaway shell and watch
# stderr instead - defining an alias runs nothing.
function __csc_alias_parses --argument-names code
    set -l err (fish --no-config -c $code 2>&1 >/dev/null)
    test -z "$err"
end

function __csc_skip --argument-names out reason source_line
    printf '# Not translated (%s):\n#   %s\n' $reason $source_line >>$out
    set -g skipped (math $skipped + 1)
    printf '  ! %s: %s\n' $reason $source_line
end

function __csc_header --argument-names out source_name
    printf '# Auto-generated from ~/.config/shell/%s - do not edit.\n' $source_name >$out
    printf '# Run ~/.config/fish/convert_shell_config.fish to regenerate.\n\n' >>$out
end

# --- environment variables -------------------------------------------------

function __csc_convert_env
    set -l src $SHELL_DIR/.env_vars
    set -l out $FISH_CONF_DIR/env_vars.fish
    test -f $src; or return
    __csc_header $out .env_vars

    while read -l line
        if __csc_is_comment $line
            printf '%s\n' $line >>$out
            continue
        end

        set -l m (string match -r '^\s*export\s+([A-Za-z_][A-Za-z0-9_]*)=(.*)$' -- $line)
        if test (count $m) -eq 0
            __csc_skip $out 'not an export' $line
            continue
        end
        set -l name $m[2]
        set -l value $m[3]

        set -l code
        if test $name = PATH
            # export PATH=$PATH:/some/dir  ->  fish_add_path /some/dir
            set -l dir (__csc_unquote $value)
            set dir (string replace -r '^\$\{?PATH\}?:' '' -- $dir)
            set dir (string replace -r ':\$\{?PATH\}?$' '' -- $dir)
            set code "fish_add_path \"$dir\""
        else
            # Keep the author's quoting. fish and bash agree on what '...' and
            # "..." mean closely enough that most values round-trip unchanged,
            # including "$(cmd)" substitutions.
            set code "set -gx $name $value"
        end

        if __csc_parses $code
            printf '%s\n' $code >>$out
        else
            __csc_skip $out 'fish cannot parse this value' $line
        end
    end <$src

    printf '  created %s\n' $out
end

# --- aliases ---------------------------------------------------------------

# Split `'body' # comment` (or "body", or a bare word) into its two parts
# without being fooled by a '#' inside the body. Sets csc_body and csc_comment.
function __csc_split_alias --argument-names rest
    set -g csc_body ''
    set -g csc_comment ''
    set -l m (string match -r '^(\'[^\']*\')\s*(#.*)?$' -- $rest)
    if test (count $m) -eq 0
        set m (string match -r '^("(?:[^"\\\\]|\\\\.)*")\s*(#.*)?$' -- $rest)
    end
    if test (count $m) -eq 0
        set m (string match -r '^([^\s#]+)\s*(#.*)?$' -- $rest)
    end
    test (count $m) -gt 0; or return 1
    set -g csc_body $m[2]
    set -g csc_comment $m[3]
end

function __csc_convert_aliases
    set -l src $SHELL_DIR/.aliases
    set -l out $FISH_CONF_DIR/aliases.fish
    test -f $src; or return
    __csc_header $out .aliases

    while read -l line
        if __csc_is_comment $line
            printf '%s\n' $line >>$out
            continue
        end

        set -l m (string match -r '^\s*alias\s+([^=\s]+)=(.*)$' -- $line)
        if test (count $m) -eq 0
            __csc_skip $out 'not an alias' $line
            continue
        end
        set -l name $m[2]

        if not __csc_split_alias $m[3]
            __csc_skip $out 'cannot separate body from comment' $line
            continue
        end
        set -l body $csc_body
        set -l inner (__csc_unquote $body)
        set -l trailer ''
        test -n "$csc_comment"; and set trailer "  $csc_comment"

        # `(cmd)` is a subshell in bash but a command substitution in fish, so
        # it would parse and then do the wrong thing. Refuse rather than guess.
        if string match -qr '(^|[;&|]\s*)\(' -- $inner
            __csc_skip $out 'bash subshell has no fish equivalent' $line
            continue
        end

        set -l code
        if string match -qr '&\s*$' -- $inner
            # fish's alias appends $argv, which would land after the & and be
            # run as its own command. Emit a function and place $argv itself.
            set -l cmd (string replace -r '\s*&\s*$' '' -- $inner)
            set code "function $name --description "(__csc_squote "alias $name=$inner")"
    $cmd \$argv &
end"
            if __csc_parses $code
                printf '%s%s\n' $code $trailer >>$out
            else
                __csc_skip $out 'fish cannot parse this body' $line
            end
        else
            set code "alias $name=$body"
            if __csc_alias_parses $code
                printf '%s%s\n' $code $trailer >>$out
            else
                __csc_skip $out 'fish cannot parse this body' $line
            end
        end
    end <$src

    printf '  created %s\n' $out
end

# --- run -------------------------------------------------------------------

echo "Converting shell configuration to fish syntax..."
__csc_convert_env
__csc_convert_aliases

echo ""
if test $skipped -gt 0
    echo "Done, but $skipped line(s) could not be translated - see the comments above."
else
    echo "Done. Reload with: exec fish"
end
