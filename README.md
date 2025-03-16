# GitHub Workshop

This is a practical workshop consisting of common GitHub-related actions.
It is based on the [`unikraft/catalog-core` repository](https://github.com/unikraft/catalog-core), giving us a concrete Git repository to screw up ... hmmmm ... to do wonderful amazing great things to.

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

### Use GitHub CLI

Then clone the three repositories above:

```console
git clone https://github.com/unikraft/unikraft
git clone https://github.com/microsoft/openvmm
git clone https://github.com/nodejs/node
```

For each repository, use the GitHub CLI tool to:

- List repository issues:

  ```console
  gh issue list
  ```

- List repository pull requests:

  ```console
  gh pr list
  ```

- List repository pull requests whose state is `closed`:

  ```console
  gh pr list -s closed
  ```

- View details about a pull request:

  ```console
  gh pr view <PR_ID>
  ```

  where `<PR_ID>` is the PR number.

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
   ./gh-reset-repo.sh
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
   ./gh-reset-repo.sh
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

## Configure Merge Strategy

We want to configure `Rebase and merge` as the only merge strategy.

For that, do the steps:

1. Go in the `Settings` tab in web view of your GitHub repository.

1. Go to the `Pull Requests` session.

1. Uncheck `Allow merge` commits and `Allow squash merging`.

Now create a new pull request and see that the only option for merging is `Rebase and merge`.

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
