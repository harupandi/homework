# DevOps Engineer Homework

This starter contains three intentional issues. Allow approximately one hour
to troubleshoot them, verify your changes, and submit your work.

## Requirements

- Bash on Linux, macOS, WSL, or Git Bash on Windows.
- Git and a GitHub account with permission to run GitHub Actions.
- No cloud account, credentials, or additional packages are needed.

Run the commands below from the repository root in Bash.

## Task 1: Fix a failing script (15 minutes)

```bash
bash task-1-script/random-data.sh
```

Correct the failure and explain what the script is doing.

## Task 2: Resolve a configuration issue (15 minutes)

```bash
bash task-2-configuration/show-service.sh
```

This script runs from the repository root but fails from another directory.
Make it work regardless of the caller's working directory. Successful runs
must print `Service: sample-worker` and `Environment: test`.

To reproduce the other-directory behavior:

```bash
repo_root="$(pwd)"
(cd .. && bash "$repo_root/task-2-configuration/show-service.sh")
```

Also verify that a missing configuration produces a useful error and a nonzero
exit code. Restore the configuration after testing.

## Task 3: Repair the automated check (20 minutes)

Review `.github/workflows/check-scripts.yml` and the GitHub Actions logs.
Fix the workflow so both corrected scripts run successfully. Keep the push
and pull request triggers, and ensure a script failure fails the workflow.

## Submission (10 minutes)

- Create your own repository from this starter, or fork it if permitted.
- Make your fixes on a branch, commit and push them, and open a pull request
  against your repository's default branch. Leave it open for review.
- Add a short findings section to this README describing each issue, how you
  identified it, your fix, and the commands or checks used to verify it.
- Provide your repository URL, pull request URL, and a successful Actions run
  URL. For private repositories, grant reviewers access.
- Do not include credentials, secrets, or employer information.

Stop after approximately one hour. If anything remains unresolved, submit
your progress, what you tried, and what you would investigate next.

## Bryan's findings

### Task 1:
- Ran script
- Saw error message: `task-1-script/random-data.sh: line 10: echo⠀Combined count: 28: command not found`
- Checking script on Visual Studio Code locally, noticed a couple issues:

| Line | Description |
| ----------- | ----------- |
| 10 | right after "echo" there's a character that breaks the "echo" command. (This wasn't visible using vim or cat, only in VS Code) |
| 12 | variable $bytes-base64 instead of $bytes_base64 |
| 13 | "ehho" instead of "echo" |

The script uses openSSL to create secure random bytes and store the result into "bytes". Then uses base64 to encode "bytes" into variable "bytes_base64". Then uses wc to count the bytes (the -c flag) for both both "bytes" and "bytes_base64". Then it adds them together and finally prints out every variable except "bytes". The script is set to fail on errors and uses bash as the interpreter.

### Task 2:
- Ran Script, fails with error `Error: configuration file not found: service.conf`
- Inspecting script, line 4:
`config_file="service.conf"`

This only works inside task-2-configuration/. I fixed it by getting the script directory from ${BASH_SOURCE[0]} so I get the service.conf file regardless of where I execute the script from. Tested it from multiple paths outside the git directory and it worked every time. The provided script already printed a message if the config file wasn't found, and exit 1 as the nonzero status.

### Task 3:
- Checked Actions logs in original repo
- Spotted error message: **"Unable to resolve action `actions/checkout@v9`, unable to find version `v9`"**. Latest version based on [documentation](https://github.com/actions/checkout/releases) is v7.0.1 
- I was unable to find the script inside the original repository, but based on the Github Actions runs, I'd change actions/checkout@v9 to a stable v6 or v7 or even pinning to a SHA to avoid supply-chain attacks.