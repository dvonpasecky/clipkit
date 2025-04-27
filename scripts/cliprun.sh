#!/bin/bash
# Run the clipboard contents as a shell command, with confirmation

VERSION=$(cat "$(dirname "$0")/../VERSION" 2>/dev/null || echo "unknown")
CLIPBOARD_FILE="$HOME/clipboard.txt"

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
    sed -n '/^## HELP START/,/^## HELP END/ p' "$0" | sed 's/^#//'
}

show_version() {
    echo "cliprun version $VERSION"
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
