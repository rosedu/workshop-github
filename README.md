# GitHub Workshop

This is a practical workshop consisting of common GitHub-related actions.
It is based on the [`unikraft/catalog-core` repository](https://github.com/unikraft/catalog-core), giving us a concrete Git repository ~~to screw up~~ to do wonderful amazing great things to.

First of all, clone the [repository](https://github.com/rosedu/workshop-github):

```console
git clone https://github.com/rosedu/workshop-github
cd workshop-github/
```

And let's get going! 🚀

> [!NOTE]
> If, at any point in time, you miss a command, or something bad simply happened, reset the environment by running:
>
> ```console
> ./gh-reset-repo.sh
> ```

> [!IMPORTANT]
> We recommend you write all commands below by hand, i.e. without using copy & paste.
> This will get you better accustomed to GitHub-related commands.

## View GitHub Repository

Let's do a quick tour of a popular GitHub repository: [`unikraft/unikraft`](https://github.com/unikraft/unikraft)

From the main repository page, we can:
- See statistics about the programming languages used.
- See information about contributors.
- See number of stars and number of forks.

### View Projects

Take a look at the [GitHub projects for the `unikraft` organization](https://github.com/orgs/unikraft/projects).
Browse the projects.

Look at the [`Release - Next` GitHub project](https://github.com/orgs/unikraft/projects/49).
Browse the items in the list.
Browse different views (tabs) in the projects.

### View Pull Requests

Take a look at [pull requests in the `unikraft` repository](https://github.com/unikraft/unikraft/pulls).
Check out a few of them. Can you find one connected to an issue?

Try filtering pull requests:
- authored by `michpappas`
- to be reviewed by `michpappas`
- that have the `area/plat` label.

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

> [!NOTE]
> Before you move on to this next step, make sure you have `unzip` installed.
>
> ```console
> sudo apt install unzip
> ```

Let's first create a work GitHub repository based on the current repository.
We will use it for toying around, messing it up and fixing it.

First, make sure you are in the local directory clone of this repository (`workshop-github`).
Then, create a repository on GitHub:

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

## Create Pull Requests

Let's now create pull requests on our GitHub repository.
A pull request is created from a series of commits in a branch.

We do the steps:

1. Create a branch for the new pull request:

   ```console
   git checkout -b <your-branch-name>-c-bye
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
   git push upstream <your-branch-name>-c-bye
   ```

1. Create a pull request by clicking on the URL that was printed by the command above.
   You will end up having a pull request created in the repository.
   The pull request is requesting for a merge to happen from the `<your-branch-name>-c-bye` to `main`.

## Review and Merge Pull Requests

The pull request should be reviewed and merged.
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

1. Now reset the repository:

   ```console
   ./gh-reset-repo.sh
   ```


1. Create your own commits and pull requests.
   Be creative.

   Create at least one pull request with two commits.
   Use the `Squash and merge` merge strategy.

## Understand git merge and git rebase

When working with multiple branches, we often need to bring changes from one branch into another.
The two most common ways to do this are:

* git merge
* git rebase

> [!IMPORTANT]
> They both integrate changes, but they do it differently.

> [!NOTE]
> In all examples below, use this command often to inspect the commit graph:
> `git log --oneline --graph --all`

## What is `git merge`?

`git merge` combines the histories of two branches.
When the two branches have diverged, Git usually creates a merge commit.

## Practical example: `git merge`

First, reset the repository:

   ``` console
   ./gh-reset-repo.sh
   ```

Make sure you are on `main || master` branch:

   ``` console
   git switch `main or master`
   ```

Verify that you are on the main branch:

   ``` console
   git branch
   ```

Create a new branch:

   ``` console
   git switch -c <your-merge-branch-name>
   ```

Verify that you are on the newly created branch:

   ``` console
   git branch
   ```

Create a first commit on this branch:

   ``` console
   mkdir merge-demo
   echo "first line" > merge-demo/notes.txt
   git add merge-demo/notes.txt
   git commit -m "Add first note in merge example"
   ```

Create a second commit on the same branch:

   ``` console
   echo "second line" >> merge-demo/notes.txt
   git add merge-demo/notes.txt
   git commit -m "Add second note in merge example"
   ```

Visualize the history:

``` console
git log --oneline --graph --all
```

At this point, the history should still be simple: `<your-merge-branch-name>` is ahead of `main` branch.

Now switch back to `main` branch and create a commit there too:

   ``` console 
   git switch main
   mkdir main-demo
   echo "change on main" > main-demo/main.txt
   git add main-demo/main.txt
   git commit -m "Add change on main branch"
   ```

Visualize the history again:

   ``` console
   git log --oneline --graph --all
   ```

Now the two branches have diverged:

* main has one new commit

* <your-merge-branch-name> has two different commits

Merge `<your-merge-branch-name>` into `main`:

   ``` console 
   git merge <your-merge-branch-name>
   ```

Visualize the history once more:

``` console 
git log --oneline --graph --all
```

You should now see a graph similar to this:

``` text
The history:

*   M Merge branch `<your-merge-branch-name>`
|\
| * C Add second note in merge example
| * B Add first note in merge example
* | D Add change on main branch
|/
* A previous commit
```

### What happened?
`git merge` took the changes from `<your-merge-branch-name>` and integrated them into `main` branch.
Because both branches had moved forward independently, Git created a `merge commit`.

### What is important here?
* the branch structure is preserved
* the history shows exactly that parallel work happened
* nothing was rewritten

## What is `git rebase`?

`git rebase` takes the commits from one branch and `replays them on top of another branch`,
creating new commits that appear after the target branch.

## Practical example: `git rebase`

Reset the repository again:

   ``` console
   ./gh-reset-repo.sh
   ```

Make sure you are on `main`:

   ``` console
   git switch main
   ```

Verify that you are on the main branch:

   ``` console
   git branch
   ```

Create a new branch:

   ``` console
   git switch -c <your-rebase-branch-name>
   ```

Verify that you are on the newly created branch:

   ``` console
   git branch
   ```

Create the first commit on this branch:

   ``` console
   mkdir rebase-demo
   echo "first line" > rebase-demo/notes.txt
   git add rebase-demo/notes.txt
   git commit -m "Add first note in rebase example"
   ```

Create the second commit on this branch:

   ``` console
   echo "second line" >> rebase-demo/notes.txt
   git add rebase-demo/notes.txt
   git commit -m "Add second note in rebase example"
   ```

Visualize the history:

   ``` console
   git log --oneline --graph --all
   ```

Now switch to `main` branch and create a commit there:

   ``` console
   git switch main
   mkdir main-demo
   echo "change on main" > main-demo/main.txt
   git add main-demo/main.txt
   git commit -m "Add change on main branch"
   ```

Visualize again:

   ``` console
   git log --oneline --graph --all
   ```

> [!IMPORTANT] At this point, just like before, the branches have diverged.

Now switch back to `<your-rebase-branch-name>`:

   ``` console
   git switch <your-rebase-branch-name>
   ```

Verify that you are on the newly created branch:

   ``` console
   git branch
   ```

Rebase it on top of `main`:

   ``` console
   git rebase main
   ```

Visualize the history again:

   ``` console
   git log --oneline --graph --all
   ```

You should now see a history similar to this:

   ``` text
   The history:

   * E Add second note in rebase example
   |
   * D Add first note in rebase example
   |
   * C Add change on main branch
   |
   * B previous commit
   |
   * A older commit
   ```

### What happened?

Git took the two commits from `<your-rebase-branch-name>` and replayed them on top of the current `main` branch.

So instead of:

   ``` console
   main:    A---B---C
                  \
   your-branch:    D---E
   ```

you now get:

   ``` console
   A---B---C---D'---E'
   ```

> [!IMPORTANT] D' and E' are new commits created by `rebase`.
They may contain the same changes, but they are rewritten commits.

### What is important here?
* git rewrites commit history
* the result looks like the work happened in a straight line
* there is usually no merge commit

## Configure Merge Strategy

We want to configure Rebase and merge as the only merge strategy.

For that, do the steps:

1. Go in the `Settings` tab in web view of your GitHub repository.

1. Go to the `Pull Requests` session.

1. Uncheck `Allow merge` commits and `Allow squash merging`.

Now create a new pull request and see that the only option for merging is `Rebase and merge`.

## Approve Pull Request

In order to approve a pull request, you need to have another user able to approve your pull requests.

Before everything, reset the repository:

```console
./gh-reset-repo.sh
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
./gh-reset-repo.sh
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

## Collaborate with GitHub

GitHub shines for collaborative / team work.
For this, work in pairs of two.

Before this, do a reset of your repository:

```
./gh-reset-repo.sh
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
