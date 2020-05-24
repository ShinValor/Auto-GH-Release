## Auto-GH-Release

Automatically create and update release notes in your GitHub repository.

### Set up

1) [Create](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) Github Developer API key<br/>
3) Type your release note in release.md using markdown syntax<br/>

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

./release.sh -k 123456 -t v1.23.45.6
```
