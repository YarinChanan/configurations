#!/bin/bash

# Function to bump version
bump_version() {
    echo "Executing bump_version function with args: $1, $2"
    local semV="$1"
    local file="$2"

    if [ "$semV" = "major" ]; then
        sed -i 's/^MINOR=[0-9]\+$/MINOR=0/' "$file"
        sed -i 's/^PATCH=[0-9]\+$/PATCH=0/' "$file"
    elif [ "$semV" = "minor" ]; then
        sed -i 's/^PATCH=[0-9]\+$/PATCH=0/' "$file"
    fi

    oldnum=$(grep "^${semV^^}=" "$file" | cut -d '=' -f2)
    newnum=$((oldnum + 1))
    sed -i "s/^${semV^^}=$oldnum\$/${semV^^}=$newnum/g" "$file"
}

#Main script logic
case "$1" in
    major|MAJOR)
        semV="major"
        ;;
    minor|MINOR)
        semV="minor"
        ;;
    patch|PATCH)
        semV="patch"
        ;;
    *)
        echo "Usage: $0 {MAJOR|MINOR|PATCH} [file]"
        exit 1
        ;;
esac

bump_version "$semV" "$2"
