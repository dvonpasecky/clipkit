#!/bin/bash
# Append text to the clipboard file, from arguments or stdin

VERSION="0.1.0"
CLIPBOARD_FILE="$HOME/clipboard.txt"

## HELP START
# clipappend - Append text to clipboard
#
# Usage:
#   clipappend "text to append"
#   echo "text" | clipappend
#
# Description:
#   Appends provided text or piped stdin to the clipboard file.
## HELP END

show_help() {
    sed -n '/^## HELP START/,/^## HELP END/ p' "$0" | sed 's/^#//'
}

show_version() {
    echo "clipappend version $VERSION"
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
if [[ $# -eq 0 ]]; then
    if [ -t 0 ]; then
        echo "Usage: clipappend \"text to append\" or echo text | clipappend"
        exit 1
    else
        cat - >> "$CLIPBOARD_FILE"
    fi
else
    echo "$*" >> "$CLIPBOARD_FILE"
fi

echo "Text appended to clipboard."
