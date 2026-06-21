# Git Advanced & GitHub Workshop

This is a practical workshop consisting of common Git Advanced & GitHub-related actions.
It is based on the [`unikraft/catalog-core` repository](https://github.com/unikraft/catalog-core), giving us a concrete Git repository to screw up ... hmmmm ... to do wonderful amazing great things to.

First of all, clone the [repository](https://github.com/rosedu/workshop-github):

```console
git clone https://github.com/rosedu/workshop-github
cd workshop-github/
```

And let's get going! 🚀

## Set Up GitHub

Let's set up GitHub for proper use.

### Add Your Public SSH Key

If you haven't already, add your public SSH key to your GitHub account.
Follow the instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

### Create a Personal Access Token

Create a personal access token to use as an authentication mechanism for GitHub.
Follow the instructions [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic).
Add **all permissions** to the personal access token.

## Set Up GitHub CLI

Follow the instruction [here](https://cli.github.com/) and install GitHub CLI.

Authenticate to GitHub:

```console
gh auth login
```

Use the username and the personal access token above to authenticate.

## Create Work GitHub Repository

Let's first create a work GitHub repository based on the current repository.
We will use it for toying around, messing it up and fixing it.

First, make sure you are in the local directory clone of this repository (`workshop-github`).
Then, create a repository on GitHub from the command line (using GitHub CLI - `gh`):

```console
./gh-create-repo.sh
```

Check your repository on GitHub using a web browser.

Your repository is now available as the `upstream` remote.
Check your remotes:

```console
git remote show
git remote show origin
git remote show upstream
```

# Git Advanced

> [!NOTE]
> If, at any point in time, you miss a command, or something bad simply happened, reset the environment by running:
>
> ```console
> ./reset-all.sh
> ```

> [!IMPORTANT]
> We recommend you write all commands below by hand, i.e. without using copy & paste.
> This will get you better accustomed to Git and Git commands.

## Edit Commit History

Let's get to a situation where we need to repair the commit history.
We will have a setup where we have the following stack of commits:

- (top) correct commit
- (next) commit that shouldn't exist (`bla bla` commit)
- (next-next) commit with a typo (`Bue` instead of `Bye`)

We want to edit the commit history and:

- Remove the `bla bla` commit.
- Fix the typo.

First, let's create the local branches we will work on (`base`, `scripts`, `test`).
They live on the remote, so we just check them out once to get local tracking branches:

```console
git checkout base
git checkout scripts
git checkout test
git checkout main
```

1. Create the setup:

   ```console
   ./set-up-history-edit.sh
   git status
   git log
   ```

1. **Note**: If, at any point in time, you miss a command, or something bad simply happened, reset the environment by running:

   ```console
   ./reset-all.sh
   ```

   Then go back to step 1 and prepare the messed up environment again.

1. Go into commit history editing mode:

   ```console
   git rebase -i HEAD~3
   ```

   The `rebase` command positions you somewhere else in the commit history.
   You can make updates to commits from that point onward.

   The `~N` construct is a reference to `N` commits before the current one.
   `HEAD~3` means 3 commits before the top commit.

   You get an editor screen with an output like this:

   ```text
   pick e5442f0 Add C Bue application
   pick 06eb1fa bla bla
   pick 74f3d3e c-bye: Add Firecracker build script for x86_64
   ```

1. Edit the rebase screen contents in order to edit the commit with the typo (`Bue` instead of `Bye`) and to drop the extra commit (the one with `bla bla`).
   Have the editor screen have the contents:

   ```
   edit e5442f0 Add C Bue application
   drop 06eb1fa bla bla
   pick 74f3d3e c-bye: Add Firecracker build script for x86_64
   ```

   That is, the first line (the bad commit message) should have `edit` instead of `pick` - we edit the commit.
   And the second line (the extra commit) should have `drop` instead of `pick` - we drop the commit.

   Save and exit the editor screen.

1. We are currently editing the typo commit:

   ```console
   git log
   git show
   ```

1. Update the commit message from `Bue` to `Bye`:

   ```console
   git log
   git commit --amend    # do edit as required
   git log
   git show
   ```

1. Continue the commit history editing:

   ```console
   git rebase --continue
   ```

   Each `git rebase --continue` command gets you to the next commit to update.

1. The extra commit has been dropped:

   ```console
   git log
   git status
   ```

1. The commit history editing (aka the rebase) is done:

   ```console
   git rebase --continue
   ```

   It says "No rebase in progress?", meaning the rebase is done.
   There are no more commits to update.

### Do It Yourself

1. Repeat the above steps at least 2 more times.

   Aim to have one time without checking the instructions.
   That is, run the `./set-up-history-edit.sh` script and then repair the commit history by yourself.

   If, at any point, you get lost, run the reset script:

   ```console
   ./reset-all.sh
   ```

1. Do your own commit history that you want to edit.
   Go to a given branch, create commits, create some bad or extra commits.
   Then repair the commit history.

   If, at any point, you get lost, run the reset script:

   ```console
   ./reset-all.sh
   ```

## Create Commits - Recap from the previous workshop

We will get some new content that we will add as commits to the repository.
Make sure you are on the `main` branch and everything is clean:

```console
git checkout main
```

Or, reset the repository:

```console
./reset-all.sh
```

1. Create contents from archive:

   ```console
   unzip support/c-bye.zip
   git status
   ```

   We now have a `c-bye/` directory:

   ```console
   ls c-bye/
   ```

   There are a lot of files.
   We want to add them as 3 separate commits in 3 separate branches.

   1. The `bye.c`, `Makefile`, `Makefile.uk`, `fc...`, `xen...`, `README.md` files will go to the `base` branch.
   1. The `defconfig...`, `build...`, `run...`, `README.scripts.md` files will go to the `scripts` branch.
   1. The `test...` files will go to the `test` branch.

1. Go to the `c-bye/` directory:

   ```console
   cd c-bye/
   ls
   ```

### `base` branch

Let's create a commit to `base` branch:

1. Check out the `base` branch:

   ```console
   git checkout base
   ```

1. Add contents to staged area:

   ```console
   git add bye.c Makefile Makefile.uk README.md xen.* fc.* .gitignore
   git status
   ```

1. Create the commit:

   ```console
   git commit -s -m 'Introduce C Bye on Unikraft'
   ```

1. List the commit:

   ```console
   git log
   git show
   ```

1. Look at the commit for the initial C Hello program:

   ```console
   git show 7fd6e9290dddc2ae799ae5df684668a7d16e87f3
   ```

   The commit message is:

   ```text
   Introduce C Hello on Unikraft

   Add `c-hello/` directory:

   - `hello.c`: the source code file
   - `Makefile.uk`: defining the source code files used
   - `Makefile`: for building the application
   - `fc.x86_64.json` / `fc.arm64.json`: Firecracker configuration
   - `xen.x86_64.cfg` / `xen.arm64.cfg`: Xen configuration
   - `README.md`: instructions
   - `.gitignore`: ignore generated files
   ```

   We want something similar for our C bye commit.

1. Update the commit message by amending:

   ```console
   git commit --amend
   ```

   You get an editable screen.
   Edit the commit message to have contents similar to the one for C Hello.
   Use copy & paste.

   You can use `git commit --amend` to constantly update the commit.

   See the final result with:

   ```console
   git log
   git show
   ```

### `scripts` branch

Let's create a commit to `scripts` branch:

1. Check out the `scripts` branch:

   ```console
   git checkout scripts
   ```

1. Add contents to staged area:

   ```console
   git add defconfig.* build.* run.* README.scripts.md
   git status
   ```

1. Create the commit:

   ```console
   git commit -s -m 'c-bye: Add scripts'
   ```

1. List the commit:

   ```console
   git log
   git show
   ```

1. Look at the commit for the initial C Hello program:

   ```console
   git show 04cf0f57f2853d73a5c25082d4652fef63da8f57
   ```

   The commit message is:

   ```text
   c-hello: Add scripts

   Use scripts as quick actions for building and running C Hello on Unikraft.

    - `defconfig.<plat>.<arch>`: default configs, used by build scripts
    - `build.<plat>.<arch>`: scripts for building Unikraft images
    - `run.<plat>.<arch>`: scripts for running Unikraft images
    - `README.script.md`: companion README with instructions
   ```

   We want something similar for our C bye commit.

1. Update the commit message by amending:

   ```console
   git commit --amend
   ```

   You get an editable screen.
   Edit the commit message to have contents similar to the one for C Hello.
   Use copy & paste.

   You can use `git commit --amend` to constantly update the commit.

   See the final result with:

   ```console
   git log
   git show
   ```

### `test` branch

Let's create a commit to `test` branch:

1. Check out the `test` branch:

   ```console
   git checkout test
   ```

1. Add contents to staged area:

   ```console
   git add test*
   git status
   ```

1. Create the commit:

   ```console
   git commit -s -m 'c-bye: Add test scripts'
   ```

1. List the commit:

   ```console
   git log
   git show
   ```

### Do It Yourself

1. Reset the configuration:

   ```console
   ./reset-all.sh
   ```

1. Repeat the above steps at least 2 more times.

   Aim to have one time without checking the instructions.
   That is, create the 3 commits in the 3 branches for C bye.

   If, at any point, you get lost, run the reset script:

   ```console
   ./reset-all.sh
   ```

1. Do the same for the C++ Bye program.

   Make sure you are on the `main` branch:

   ```console
   git status
   git checkout main
   ```

   First unpack the contents:

   ```console
   unzip support/cpp-bye.zip
   git status
   ```

   We now have a `cpp-bye/` directory:

   ```console
   ls cpp-bye/
   ```

   There are a lot of files.
   We want to add them as 3 separate commits in 3 separate branches.

   1. The `bye.cpp`, `Makefile`, `Makefile.uk`, `Config.uk`, `fc...`, `xen...`, `README.md` files will go to the `base` branch.
   1. The `defconfig...`, `build...`, `run...`, `README.scripts.md` files will go to the `scripts` branch.
   1. The `test...` files will go to the `test` branch.

   Follow the steps for C Bye to create the commits for C++ Bye.

1. Do the same for the Python Bye program.

   Make sure you are on the `main` branch:

   ```console
   git status
   git checkout main
   ```

   First unpack the contents:

   ```console
   unzip support/python3-bye.zip
   git status
   ```

   We now have a `python3-bye/` directory:

   ```console
   ls python3-bye/
   ```

   There are a lot of files.
   We want to add them as 3 separate commits in 3 separate branches.

   1. The `bye.py`, `Makefile`, `Makefile.uk`, `Config.uk`, `fc...`, `xen...`, `README.md` files will go to the `base` branch.
   1. The `defconfig...`, `build...`, `run...`, `README.scripts.md` files will go to the `scripts` branch.
   1. The `test...` files will go to the `test` branch.

   Follow the steps for C bye to create the commits for Python3 Bye.

## Create Commit History

At this point there are commits in the `base` branch that are not part of the `scripts` branch.
And there are commits in the `scripts` branch that are not part of the `test` branch.

We aim to have the `scripts` branch built on top of the `base` branch.
And we want to have the `test` branch built on top of the `scripts` branch.

For this, all commits from the `base` branch will have to be on the `scripts` branch.
And all commits from the `scripts` branch will have to be on the `test` branch.

1. To get the `c-bye` commit from the `base` branch to the `scripts` branch, first check out the `scripts` branch:

   ```console
   git checkout scripts
   ```

1. Find out the commit ID in the `base` branch:

   ```console
   git log base
   ```

   Scroll the commit history and copy the commit ID belonging to the `c-bye` program.
   That is, the ID of the commit you created earlier with the message: `Introduce C Bye on Unikraft`.

1. Use the commit ID cherry pick the commit from the `base` branch to the `scripts` branch:

   ```console
   git cherry-pick <commit-id>
   ```

   Replace `<commit-id>` with the commit ID you copied above (copy & paste).

1. Check the updated history of the `scripts` branch:

   ```console
   git log
   ```

1. To get the `c-bye` commits from the `scripts` branch to the `test` branch, first check out the `test` branch:

   ```console
   git checkout test
   ```

1. First cherry pick the `base` commit that is now on `scripts`:

   ```console
   git cherry-pick <commit-id>
   ```

   This is the same commit ID from above.

   **Cherry-picking** is selecting a commit, or series of commits and adding them on top of the current setup.

1. Now let's get the `c-bye` commit from the `scripts` branch.
   Find out the commit ID in the `scripts` branch:

   ```console
   git log scripts
   ```

   Scroll the commit history and copy the commit ID belonging to the `c-bye` program.
   That is, the ID of the commit you created earlier with the message: `c-bye: Add scripts`.

1. Use the commit ID cherry pick the commit from the `scripts` branch to the `test` branch:

   ```console
   git cherry-pick <new-commit-id>
   ```

   Replace `<new-commit-id>` with the commit ID you copied above (copy & paste).

1. Check the updated history of the `scripts` branch:

   ```console
   git log
   ```

> [!NOTE]
> If, at any point, you did something wrong, recall that you can drop the top commit by doing:
>
> ```console
> git reset --hard HEAD^
> ```

### Do It Yourself

1. Repeat the above steps at least 2 more times.

   Aim to have one time without checking the instructions.
   That is, have the `scripts` based on the `base` branch, and have the `test` branch based on the `scripts` branch.

   For starters, drop the newly cherry-picked commit from the `scripts` branch:

   ```console
   git checkout scripts
   git reset --hard HEAD^
   ```

   And drop the newly cherry-picked commits from the `test` branch:

   ```console
   git checkout test
   git reset --hard HEAD^^
   ```

   Now repeat the steps above.

1. Do the same steps for the C++ Bye program.
   That is, have the `scripts` based on the `base` branch, and have the `test` branch based on the `scripts` branch.

1. Do the same steps for the Python Bye program.
   That is, have the `scripts` based on the `base` branch, and have the `test` branch based on the `scripts` branch.

## Update Commit History

At this point, the `scripts` branch is based on the `base` branch.
And the `test` branch is based on the `scripts` branch.

What we do not like, however, is that the commits in the `scripts` and the `test` branch are not in the correct order.

In the `scripts` branch the commits are (top-to-bottom):

- python3-bye: Add scripts
- Introduce Python3 Bye
- cpp-bye: Add scripts
- Introduce C++ Bye
- c-bye: Add scripts
- Introduce C Bye
- python3-bye: Add test scripts
- cpp-bye: Add test scripts
- c-bye: Add test scripts

Use `git log` to confirm this:

```console
git log
git log --oneline
```

The order we want is (top-to-bottom):

- python3-bye: Add test scripts
- python3-bye: Add scripts
- Introduce Python3 Bye
- cpp-bye: Add test scripts
- cpp-bye: Add scripts
- Introduce C++ Bye
- c-bye: Add scripts
- Introduce C Bye
- c-bye: Add test scripts

So, to update the commit history, follow the steps below:

1. Enter the history update mode.
   Update the last `9` commits:

   ```console
   git rebase -i HEAD~9
   ```

   You are now in a custom editor mode where you can update the commits.

1. Move the commits (cut & paste) to get to the new commit history.
   Do this by cutting and pasting the lines in the commit history.

1. Save the custom editor mode.

You're done.
Check the new commit history with:

```console
git log
git log --oneline
```

### Do It Yourself

Edit the commit history on the `test` branch so the commits are in the correct order, just like they are on the `scripts` branch.

# GitHub

> [!NOTE]
> If, at any point in time, you miss a command, or something bad simply happened, reset the environment by running:
>
> ```console
> ./reset-all.sh --github
> ```

> [!IMPORTANT]
> We recommend you write all commands below by hand, i.e. without using copy & paste.
> This will get you better accustomed to GitHub-related commands.

## View GitHub Repositories

Take a look at the following repositories:

- [`unikraft/unikraft`](https://github.com/unikraft/unikraft)
- [`microsoft/openvmm`](https://github.com/microsoft/openvmm)
- [`nodejs/node`](https://github.com/nodejs/node)

Do a tour of as much information as possible about them:

- See statistics about the programming languages used.
- See information about contributors.
- See number of stars and number of forks.
- Take a quick look at the issues and pull requests.

### View Projects

Take a look at the [GitHub projects for the `unikraft` organization](https://github.com/orgs/unikraft/projects).
Browse the projects.

Look at the [`Release - Next` GitHub project](https://github.com/orgs/unikraft/projects/49).
Browse the items in the list.
Browse different views (tabs) in the projects.

### View Pull Requests

Take a look at [pull requests in the `unikraft` repository](https://github.com/unikraft/unikraft/pulls).
Select 3 pull requests and check them out.
Look at the discussions, changes, checks for each pull request.

Identify a pull request that is connected to an issue.

Select pull requests that have been authored by `michpappas`.

Select pull requests that are to be reviewed by `michpappas`.

Select pull requests that use the `area/plat` label.

## Create Pull Requests

Let's now create pull requests on our GitHub repository.
A pull request is created from a series of commits in a branch.

We do the steps:

1. Create a branch for the new pull request:

   ```console
   git checkout -b add-c-bye
   ```

1. Create the contents of the `c-bye` program:

   ```console
   unzip support/c-bye.zip
   ```

1. Create commit:

   ```console
   git add c-bye/
   git commit -s -m 'Introduce c-bye program'
   ```

1. Push commit to the `upstream` remote:

   ```console
   git push upstream add-c-bye
   ```

1. Create a pull request by clicking on the URL that was printed by the command above.
   You will end up having a pull request created in the repository.
   The pull request is requesting for a merge to happen from the `add-c-bye` to `main`.

### Do It Yourself

1. Repeat the above steps at least 2 more times.
   Reset before each step:

   ```console
   ./reset-all.sh --github
   ```

1. Do the same steps as above for the `cpp-bye` and `python3-bye` programs in the `support/` directory.
   You should end up with three pull requests.

## Review and Merge Pull Requests

The pull requests should be reviewed and merged.
For that, in the GitHub web interface for the pull request follow the steps:

1. Go to the `Files changed` tab.

1. Click the `Review changes` button.

1. Aim to approve your pull request.
   You cannot approve your pull request, if you're the author.

1. Now, get back to the `Conversation` tab.
   Go below to the `Merge pull request` button.

   Below clicking the button, see the options from the little drop-down option on the right.
   See what are the options, choose one and do it.

### Do It Yourself

1. Do the steps above for all 3 pull requests.

1. Now reset the repository:

   ```console
   ./reset-all.sh --github
   ```

   and redo the pull requests, and merge them again.

1. Create your own commits and pull requests.
   Be creative.

   Create at least one pull request with two commits.
   Use the `Squash and merge` merge strategy.

## Approve Pull Request

In order to approve a pull request, you need to have another user able to approve your pull requests.

Before everything, reset the repository:

```console
./reset-all.sh --github
```

And create the pull request, as above.

To add someone to be able to approve your pull requests, they need to have `Triage` permissions.
For this, do the following:

1. Go to the `Settings` tab in the GitHub web view of your repository.

1. Go to the `Collaborators` entry in the left menu.
   You'll have to provide your GitHub password, or use some other authentication method.

1. Ask someone around you for their GitHub username.
   Add them to the repository as collaborator.

1. Ask them to confirm the invite via e-mail or by accessing the invitation URL: `https://github.com/<your-github-username>/workshop-github/invitations`.
   Replace `<your-github-username>` with your GitHub username.

1. Ask them to approve your pull request.

1. Now merge the pull request.

## Require Approval for Pull Requests

We want to enforce an approval for our pull requests.

Before everything, reset the repository:

```console
./reset-all.sh --github
```

And create the pull request, as above.

Now add a ruleset to add a required approval condition.
For this, do the following:

1. Go to the `Settings` tab in the GitHub web view of your repository.

1. Go to the `Branches` entry in the left menu.

1. Click `Add branch ruleset`.

1. Check `Require a pull request before merging`.

1. Add `1` to `Required approvals`.

1. Now ask for an approval for your pull request, as above.

1. Merge the pull request with the approval now done.

## Configure Merge Strategy

We want to configure `Rebase and merge` as the only merge strategy.

For that, do the steps:

1. Go in the `Settings` tab in web view of your GitHub repository.

1. Go to the `Pull Requests` session.

1. Uncheck `Allow merge` commits and `Allow squash merging`.

Now create a new pull request and see that the only option for merging is `Rebase and merge`.

## Tag a Release

A **tag** marks a specific commit in history, usually to flag a release or version (for example `v1.0`).
Unlike a branch, a tag does not move - it always points to the same commit.

1. Create an annotated tag on the current commit:

   ```console
   git tag -a v1.0 -m "First release of the C Bye application"
   ```

1. List the tags and inspect one:

   ```console
   git tag
   git show v1.0
   ```

1. Push the tag to GitHub (tags are **not** pushed by `git push` by default):

   ```console
   git push origin v1.0
   ```

   To push all your tags at once, use `git push origin --tags`.

1. In the web view of your GitHub repository, go to the `Tags` / `Releases` section.
   You will see the `v1.0` tag.
   From there you can also turn a tag into a published `Release`.

To delete a tag (locally and on GitHub), use:

```console
git tag -d v1.0
git push origin --delete v1.0
```

## Collaborate with GitHub

GitHub shines for collaborative / team work.
For this, work in pairs of two.

Before this, do a reset of your repository:

```
./reset-all.sh --github
```

Each of you should do the following:

1. Create a fork of the other's repository.
   Be sure to give it a different name, not to clash with your own `workshop-github` repository name.

1. Clone the fork locally:

   ```console
   git clone <fork_url>
   cd <clone_directory>
   ```

   where `<fork_url>` is the URL of the other's repository, and `<clone_directory>` is the directory of the repository clone.

1. Create a branch and commit(s) from `c-bye`.

1. Push the branch to the `origin` remote (belonging to your fork).

1. Create a pull request to the other's repository (from fork to the initial repository).

1. The other person should approve and merge your pull request.

Do this multiple times, be creative, use your own ideas.

## Your Own Repository

Now, let's get really creative.

Continue working in pairs of two.

Each of you should create their own repository, with whatever content they want.
Create it from scratch, be creative, do whatever you want.
Configure the repository to use the `Rebase and merge` strategy.

Ask the other to fork your repository and then ask the other to create a pull request.
Toy around.

### Nice To Do

Before asking for a pull request, create an issue on your repository, and ask the other to "solve" the issue by creating a corresponding pull request.
Link the pull request to the issue once it is created, by following instructions [here](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue).
