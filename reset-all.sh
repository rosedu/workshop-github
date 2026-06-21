#!/bin/sh

# Usage:
#   ./reset.sh            # local reset only
#   ./reset.sh --github   # full GitHub reset

if [ "$1" = "--github" ] && ! command -v gh > /dev/null 2>&1; then
    echo "gh could not be found" >&2
    exit 1
fi

reset_branch_to_remote()
{
    if ! git rev-parse --verify "$1" > /dev/null 2>&1; then
        return
    fi

    git checkout "$1"
    git reset --hard "$2/$1"
}

clean_branch()
{
    git checkout "$1"
    git merge --abort > /dev/null 2>&1
    git rebase --abort > /dev/null 2>&1
    git cherry-pick --abort > /dev/null 2>&1
    git reset --hard HEAD
    git clean -d -f
}

# Abort any ongoing actions
git merge --abort > /dev/null 2>&1
git rebase --abort > /dev/null 2>&1
git cherry-pick --abort > /dev/null 2>&1
git reset --hard HEAD

# Clean branches
clean_branch test
clean_branch scripts
clean_branch base
clean_branch main

if [ "$1" = "--github" ]; then
    git remote rm true-origin 2>/dev/null
    git remote add true-origin https://github.com/rosedu/workshop-github

    git fetch true-origin

    reset_branch_to_remote test true-origin
    reset_branch_to_remote scripts true-origin
    reset_branch_to_remote base true-origin
    reset_branch_to_remote main true-origin

    git push --force upstream main

    repo_name=$(git remote show upstream | grep 'Fetch URL' |
        sed 's/\.git//' |
        rev |
        awk -F '[/:]' '{print $1"/"$2;}' |
        rev)

    gh repo set-default "$repo_name"

    for pr in $(gh pr list --json number | jq '.[] | values[]'); do
        gh pr close "$pr" -d
    done
else
    git fetch origin

    reset_branch_to_remote test origin
    reset_branch_to_remote scripts origin
    reset_branch_to_remote base origin
    reset_branch_to_remote main origin
fi
