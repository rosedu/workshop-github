#!/bin/sh

# Check for GitHub CLI command.
if ! command -v gh > /dev/null 2>&1; then
    echo "gh Could Not Be Found" 1>&2
    exit 1
fi

# Remove repository if it exists.
gh repo delete --yes workshop-github

# Remove upstream if it exists.
git remote rm upstream

# Create GitHub repository from local clone.
gh repo create workshop-github --public --remote=upstream --source=. --push
