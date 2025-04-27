#!/bin/bash
# Print the contents of the clipboard file

VERSION=$(cat "$(dirname "$0")/../VERSION" 2>/dev/null || echo "unknown")
CLIPBOARD_FILE="$HOME/clipboard.txt"

## HELP START
# clippaste - Show clipboard contents
#
# Usage:
#   clippaste
#
# Description:
#   Prints the current clipboard contents to standard output.
## HELP END

show_help() {
    sed -n '/^## HELP START/,/^## HELP END/ p' "$0" | sed 's/^#//'
}

show_version() {
    echo "clippaste version $VERSION"
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

cat "$CLIPBOARD_FILE"
