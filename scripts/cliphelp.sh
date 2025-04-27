#!/bin/bash
# Show aggregated help for all clipkit tools

VERSION="0.1.0"

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
    sed -n '/^## HELP START/,/^## HELP END/ p' "$0" | sed 's/^#//'
}

show_version() {
    echo "cliphelp version $VERSION"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    show_version
    exit 0
fi

# Detect if stdout is a terminal
if [[ -t 1 ]]; then
    BOLD_YELLOW="\033[1;33m"
    RESET="\033[0m"
else
    BOLD_YELLOW=""
    RESET=""
fi

# Header
echo -e "${BOLD_YELLOW}clipkit - Lightweight Clipboard Utility Suite${RESET}"
echo
echo "Available commands and usage:"
echo

# Find all clip* commands dynamically
CLIPKIT_COMMANDS=$(compgen -c | grep -E '^clip[^ ]*$' | sort -u)

# Loop over each command
for cmd in $CLIPKIT_COMMANDS; do
    SCRIPT_PATH="$(command -v "$cmd" 2>/dev/null)"
    if [[ -x "$SCRIPT_PATH" ]]; then
        echo -e "${BOLD_YELLOW}# $cmd${RESET}"
        sed -n '/^## HELP START/,/^## HELP END/ p' "$SCRIPT_PATH" | sed 's/^#//'
        echo
    fi
done
