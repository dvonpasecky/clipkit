#!/bin/bash
# Append text to the clipboard file, from arguments or stdin

VERSION="@VERSION@"
CLIPBOARD_FILE="${CLIPBOARD_FILE:-$HOME/clipboard.txt}"  # Default unless overridden

# Colors if outputting to terminal
if [[ -t 1 ]]; then
    BOLD_YELLOW="\033[1;33m"
    RESET="\033[0m"
else
    BOLD_YELLOW=""
    RESET=""
fi

# Script name for help header
SCRIPT_NAME="$(basename "$0")"

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
