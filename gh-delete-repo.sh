#!/bin/sh

# Check for GitHub CLI command.
if ! command -v gh > /dev/null 2>&1; then
    echo "gh could not be found" 1>&2
    exit 1
fi

# Remove repository if it exists.
# WARNING: this destroys the GitHub repository named `workshop-github` in
# your account, including a fork of the workshop if that is what it is.
if gh repo view workshop-github > /dev/null 2>&1; then
    owner=$(gh api user -q .login)
    echo "About to DELETE the GitHub repository $owner/workshop-github."
    echo "Everything in it (branches, pull requests, issues) will be lost."
    printf "Type 'yes' to continue: "
    read -r answer
    if [ "$answer" != "yes" ]; then
        echo "Aborted." 1>&2
        exit 1
    fi
    gh repo delete --yes workshop-github
fi

# Remove upstream if it exists.
git remote rm upstream > /dev/null 2>&1
