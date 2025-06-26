#!/bin/bash

# Interactive Symlink Creator
# Usage: ./link_all_safe.sh /path/to/source /path/to/destination

SOURCE="$1"
DEST="$2"

# Function to prompt user with choices
prompt_user() {
    local target="$1"
    echo "Target '$target' already exists."
    select choice in "Skip" "Overwrite" "Rename"; do
        case $REPLY in
            1) return 1 ;;  # Skip
            2) return 2 ;;  # Overwrite
            3) return 3 ;;  # Rename
            *) echo "Invalid option. Choose 1, 2 or 3." ;;
        esac
    done
}

# Validate arguments
if [[ -z "$SOURCE" || -z "$DEST" ]]; then
    echo "Usage: $0 /path/to/source /path/to/destination"
    exit 1
fi

if [[ ! -d "$SOURCE" ]]; then
    echo "Error: Source '$SOURCE' is not a directory or doesn't exist."
    exit 1
fi

mkdir -p "$DEST" || { echo "Error: Could not create/access destination '$DEST'"; exit 1; }

# Process each entry in the source
for entry in "$SOURCE"/*; do
    [[ -e "$entry" ]] || continue  # skip if no matches (empty dir)

    name=$(basename "$entry")
    target="$DEST/$name"

    if [[ -L "$target" || -e "$target" ]]; then
        prompt_user "$target"
        choice=$?

        if [[ $choice -eq 1 ]]; then
            echo "Skipped: $target"
            continue
        elif [[ $choice -eq 2 ]]; then
            rm -rf "$target"
            echo "Overwritten: $target"
        elif [[ $choice -eq 3 ]]; then
            read -p "Enter new name for link: " new_name
            target="$DEST/$new_name"
        fi
    fi

    ln -s "$entry" "$target"
    echo "Linked: $target → $entry"
done

