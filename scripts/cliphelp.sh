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

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    show_version
    exit 0
fi

# Header
echo -e "${BOLD_YELLOW}${TOOLSET_NAME} - Lightweight Clipboard Utility Suite${RESET}"
echo
echo "Available commands and usage:"
echo

# Find all installed clip* commands
CLIPKIT_COMMANDS=()

while IFS= read -r cmd; do
    SCRIPT_PATH="$(command -v "$cmd" 2>/dev/null)"
    if [[ -x "$SCRIPT_PATH" ]] && [[ "$(file --mime-type -b "$SCRIPT_PATH")" == text/* ]]; then
        CLIPKIT_COMMANDS+=("$cmd")
    fi
done < <(compgen -c | grep -E '^clip[^ ]*$' | sort -u)

# Display help for each clean script
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
