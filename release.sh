#!/bin/bash

PACKAGE='Git Release Automation'
TOKEN=""
TAG=""
FILEPATH="release.md"
OWNER=""
REPOS=()
REPOS_ID=()
COMMAND=""
NOTE=""

print_usage() {
    echo "$PACKAGE - Automating release note in Git."
    echo " "
    echo "SYNOPSIS:"
    echo "       ./run.sh [options]"
    echo " "
    echo "OPTIONS:"
    echo "-h     show brief help"
    echo "-k     specify the Github API key (Required)"
    echo "-t     specify the release-tag (Required)"
    # echo "-f     specify the release-note file path (Required)"
    # echo "-c     specify the command to execute"
    echo "-o     specify the owner of the repos"
    echo "-r     specify the repos"
}

print_info(){
    echo "-----------------"
    echo "Token: $TOKEN"
    echo "Tag: $TAG"
    echo "Filepath: $FILEPATH"
    echo "Repos' Owner: $OWNER"
    echo "Repos:"
    for REPO in "${REPOS[@]}"
    do
        echo "---- $REPO"
    done
    # echo "Command: $COMMAND"
    echo "-----------------"
}

if [[ "$1" =~ ^((-{1,2})([Hh]$|[Hh][Ee][Ll][Pp])|)$ ]]; then
    print_usage;
    exit 1
else
    while [[ $# -gt 0 ]]; do
        opt="$1"
        shift;
        current_arg="$1"
        if [[ "$current_arg" =~ ^-{1,2}.* ]]; then
            echo "WARNING: Blank argument. Double check your command."
        fi
        case "$opt" in
            "-k"|"--key"     ) TOKEN="$1"; shift;;
            "-t"|"--tag"     ) TAG="$1"; shift;;
            "-f"|"--file"    ) FILEPATH="$1"; shift;;
            "-c"|"--command" ) COMMAND="$1"; shift;;
            "-o"|"--owner"   ) OWNER="$1"; shift;;
            "-r"|"--repos"   ) repos="$1"; shift;;
            *                ) echo "ERROR: Invalid option: \""$opt"\"" >&2
                               exit 1;;
        esac
    done
fi

if [[ "$TOKEN" == "" || "$TAG" == "" || "$FILEPATH" == "" ]]; then
    echo "ERROR: Options -k and -t and -f are required arguments." >&2
    exit 1
fi

# Running
echo "Executing . . ."

# Print info
print_info

# Process markdown file
while IFS= read -r line
do
    NOTE+="$line\n"
done < $FILEPATH

# Create tag and release note
# This is used in case the release has been not created
for REPO in "${REPOS[@]}"
do
    curl -k -X POST -H "Authorization: token $TOKEN"  -d '{"tag_name": "'"$TAG"'", "name":"Release '"$TAG"'"}' "https://api.github.com/repos/$OWNER/$REPO/releases"
done

# Update release note based on tag id
for REPO in "${REPOS[@]}"
do
    ID=`curl -k -X GET -H "Authorization: token $TOKEN" "https://api.github.com/repos/$OWNER/$REPO/releases/tags/$TAG" | ./jq -r ".id"`
    curl -k -X PATCH -H "Authorization: token $TOKEN"  -d '{"tag_name": "'"$TAG"'", "name":"Release '"$TAG"'", "body":"'"$NOTE"'"}' "https://api.github.com/repos/$OWNER/$REPO/releases/$ID"
done
