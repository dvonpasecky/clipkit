#!/bin/bash
# Clear the clipboard file

VERSION="0.1.0"
CLIPBOARD_FILE="$HOME/clipboard.txt"

## HELP START
# clipclear - Clear clipboard contents
#
# Usage:
#   clipclear
#
# Description:
#   Clears the contents of the clipboard file.
## HELP END

show_help() {
    sed -n '/^## HELP START/,/^## HELP END/ p' "$0" | sed 's/^#//'
}

show_version() {
    echo "clipclear version $VERSION"
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
> "$CLIPBOARD_FILE"
echo "Clipboard cleared."
