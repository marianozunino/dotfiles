#!/bin/bash

# Old HTTPS URL
OLD_URL=$(git remote get-url origin)

# Check if the current URL is already using SSH
if [[ $OLD_URL == "https://github.com"* ]]; then
    # Extract the GitHub username and repository name from the old URL
    USER_REPO=$(echo $OLD_URL | sed -n 's|^https://github.com/\(.*\)\(.git\)\{0,1\}$|\1|p')

    # New SSH URL
    NEW_URL="git@github.com:$USER_REPO.git"
    echo "New URL: $NEW_URL"

    # Update the remote URL to use SSH
    git remote set-url origin $NEW_URL

    echo "Remote URL updated to use SSH."
else
    echo "Remote URL is already using SSH or a different protocol."
fi
