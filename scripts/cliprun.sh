#!/bin/bash
# Run the clipboard contents as a shell command, with confirmation

VERSION=$(cat "$(dirname "$0")/../VERSION" 2>/dev/null || echo "unknown")
CLIPBOARD_FILE="$HOME/clipboard.txt"

# Colors if outputting to terminal
if [[ -t 1 ]]; then
    BOLD_YELLOW="\033[1;33m"
    RESET="\033[0m"
else
    BOLD_YELLOW=""
    RESET=""
fi

## HELP START
# cliprun - Run clipboard contents as a command
#
# Usage:
#   cliprun
#
# Description:
#   Prints and executes clipboard contents after confirmation.
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

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    show_version
    exit 0
fi

# Main logic
if [[ ! -f "$CLIPBOARD_FILE" ]]; then
    echo "Clipboard is empty."
    exit 1
fi

COMMAND=$(<"$CLIPBOARD_FILE")

echo
echo "Command to run:"
echo "========================================"
echo "$COMMAND"
echo "========================================"
echo

read -rp "Are you sure you want to run this? (y/n) " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    bash "$CLIPBOARD_FILE"
else
    echo "Cancelled."
fi
