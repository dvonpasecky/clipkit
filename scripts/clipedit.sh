#!/bin/bash
# Edit the clipboard manually using nano

VERSION="0.1.0"
CLIPBOARD_FILE="$HOME/clipboard.txt"

## HELP START
# clipedit - Edit clipboard contents
#
# Usage:
#   clipedit
#
# Description:
#   Opens the clipboard file in nano for manual editing.
## HELP END

show_help() {
    sed -n '/^## HELP START/,/^## HELP END/ p' "$0" | sed 's/^#//'
}

show_version() {
    echo "clipedit version $VERSION"
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
nano "$CLIPBOARD_FILE"
