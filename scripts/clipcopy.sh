#!/bin/bash
# Save text to the clipboard file, from arguments or stdin

VERSION=$(cat "$(dirname "$0")/../VERSION" 2>/dev/null || echo "unknown")
CLIPBOARD_FILE="$HOME/clipboard.txt"

## HELP START
# clipcopy - Save text to clipboard
#
# Usage:
#   clipcopy "text to save"
#   echo "text" | clipcopy
#
# Description:
#   Copies provided text or piped stdin into the clipboard file.
## HELP END

show_help() {
    sed -n '/^## HELP START/,/^## HELP END/ p' "$0" | sed 's/^#//'
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    echo "clipcopy version $VERSION"
    exit 0
fi

# Main logic
if [[ $# -eq 0 ]]; then
    if [ -t 0 ]; then
        echo "Usage: clipcopy \"text to copy\" or echo text | clipcopy"
        exit 1
    else
        cat - > "$CLIPBOARD_FILE"
    fi
else
    echo "$*" > "$CLIPBOARD_FILE"
fi

echo "Text saved to clipboard."
