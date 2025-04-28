#!/bin/bash
# Show aggregated help for all clipkit tools

VERSION="@VERSION@"
TOOLSET_NAME="clipkit"

# Colors if outputting to terminal
if [[ -t 1 ]]; then
    BOLD_YELLOW="\033[1;33m"
    RESET="\033[0m"
else
    BOLD_YELLOW=""
    RESET=""
fi

SCRIPT_NAME="$(basename "$0")"

## HELP START
# cliphelp - Show help for all clipkit tools
#
# Usage:
#   cliphelp
#
# Description:
#   Aggregates help documentation from all installed clipkit scripts.
## HELP END

show_help() {
    TITLE=" $SCRIPT_NAME "
    EDGE=$(printf '%*s' "${#TITLE}" '' | tr ' ' '=')

    echo -e "${BOLD_YELLOW}${EDGE}${RESET}"
    echo -e "${BOLD_YELLOW}${TITLE}${RESET}"
    echo -e "${BOLD_YELLOW}${EDGE}${RESET}"
    echo

    sed -n '/^## HELP START/,/^## HELP END/ {
        /^## HELP START/d
        /^## HELP END/d
        s/^#//
        p
    }' "$0"

    echo
}

show_version() {
    echo "$SCRIPT_NAME version $VERSION"
}

show_external_help() {
    local script_path="$1"
    sed -n '/^## HELP START/,/^## HELP END/ {
        /^## HELP START/d
        /^## HELP END/d
        s/^#//
        p
    }' "$script_path"
}

# Handle -h and --help immediately
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

# Handle -v and --version immediately
if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    show_version
    exit 0
fi

# Populate CLIPKIT_COMMANDS first
CLIPKIT_COMMANDS=()
while IFS= read -r cmd; do
    if [[ "$cmd" == "clipkit" ]]; then
        continue
    fi
    SCRIPT_PATH="$(command -v "$cmd" 2>/dev/null)"
    if [[ -x "$SCRIPT_PATH" ]]; then
        CLIPKIT_COMMANDS+=("$cmd")
    fi
done < <(compgen -c | grep -E '^clip[a-z]+$' | sort -u)

# Check if any commands found
if [[ ${#CLIPKIT_COMMANDS[@]} -eq 0 ]]; then
    echo -e "${BOLD_YELLOW}No clipkit commands found.${RESET}"
    exit 1
fi

# Sort commands alphabetically
CLIPKIT_COMMANDS=($(printf '%s\n' "${CLIPKIT_COMMANDS[@]}" | sort))

# Handle -l and --list AFTER discovery
if [[ "$1" == "-l" || "$1" == "--list" ]]; then
    echo "Available clipkit commands:"
    for cmd in "${CLIPKIT_COMMANDS[@]}"; do
        echo "$cmd"
    done
    exit 0
fi

# Only print header if not in list mode
echo -e "${BOLD_YELLOW}${TOOLSET_NAME} (v${VERSION}) - Lightweight Clipboard Utility Suite${RESET}"
echo
echo "Available commands and usage:"
echo

# Display full help for each command
for cmd in "${CLIPKIT_COMMANDS[@]}"; do
    SCRIPT_PATH="$(command -v "$cmd" 2>/dev/null)"
    if [[ -x "$SCRIPT_PATH" ]]; then
        TITLE=" $cmd "
        EDGE=$(printf '%*s' "${#TITLE}" '' | tr ' ' '=')
        echo -e "${BOLD_YELLOW}${EDGE}${RESET}"
        echo -e "${BOLD_YELLOW}${TITLE}${RESET}"
        echo -e "${BOLD_YELLOW}${EDGE}${RESET}"
        echo
        show_external_help "$SCRIPT_PATH"
        echo
    fi
done
