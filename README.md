## Git-Release-Note-Automation

Implement automatically creating and updating the Release Notes in GitHub so that they do not have to be done manually every time for each GitHub repository when a build is released.

### Set up

1) [jq](https://stedolan.github.io/jq/) executable in the root directory<br/>
2) [Create](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) Github Developer API key<br/>
3) Type your release-note in release.md using markdown syntax<br/>

### Usage

Git Release Automation - Automating release note in Git.

<pre>

SYNOPSIS:<br/>
        ./release.sh [options]<br/>

OPTIONS:<br/>
-h      show brief help
-k      specify the Github API key (Required)
-t      specify the release-tag (Required)

</pre>

### Example

```
./release.sh -k YOUR_TOKEN -t YOUR_TAG

./release.sh -k 123456 -t v5.20.02.1
```

## Git-Commit-Automation

### Set up

1) [jq](https://stedolan.github.io/jq/) executable in the root directory<br/>
2) [Create](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) Github Developer API key<br/>

### How it works

Git Commit Automation - Automating fetch commit messages in Git.

<pre>

SYNOPSIS:<br/>
        ./release.sh [options]<br/>

OPTIONS:<br/>
-h      show brief help
-k      specify the Github API key (Required)
-b      specify the branch (Default to master)
-f      specify the filepath to fetch commits (Default to entire repo)

</pre>
