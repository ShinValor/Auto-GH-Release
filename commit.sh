#!/bin/bash

PACKAGE='Git Commit Automation'
SINCE="2020-01-24:00:00:00Z"
UNTIL=""
BRANCH="master"
TOKEN=""
OWNER=""
REPOS=()
FILEPATHS=()
COMMAND=""

print_usage() {
    echo "'$PACKAGE' - Automating fetch commits in Git"
    echo " "
    echo "Options:"
    echo "-h     show brief help"
    echo "-k     specify the github api key (Required)"
    echo "-b     specify branch (Default to master)"
    echo "-f     specify the filepath (Default to entire repo)"
    echo "-o     specify the owner of the repos"
    echo "-r     specify the repos"
}

print_info(){
    echo "-----------------"
    echo "Token: $TOKEN"
    echo "Branch: $BRANCH"
    echo "Filepath: $FILEPATHS"
    echo "Repos' Owner: $OWNER"
    echo "Repos:"
    for REPO in "${REPOS[@]}"
    do
        echo "---- $REPO"
    done
    echo "-----------------"
}

# if [[ "$1" =~ ^((-{1,2})([Hh]$|[Hh][Ee][Ll][Pp])|)$ ]]; then
#     print_usage;
#     exit 1
# else
#     while [[ $# -gt 0 ]]; do
#         opt="$1"
#         shift;
#         current_arg="$1"
#         if [[ "$current_arg" =~ ^-{1,2}.* ]]; then
#             echo "WARNING: Blank argument. Double check your command."
#         fi
#         case "$opt" in
#             "-k"|"--key"     ) TOKEN="$1"; shift;;
#             "-b"|"--branch"  ) BRANCH"$1"; shift;;
#             "-f"|"--file"    ) FILEPATHS="$1"; shift;;
#             "-o"|"--owner"   ) OWNER="$1"; shift;;
#             "-r"|"--repos"   ) repos="$1"; shift;;
#             *                ) echo "ERROR: Invalid option: \""$opt"\"" >&2
#                                exit 1;;
#         esac
#     done
# fi

# if [[ "$TOKEN" == "" ]]; then
#     echo "ERROR: Options -k and -t and -f are required arguments." >&2
#     exit 1
# fi

# Running
echo "Executing . . ."

# Print info
print_info

# Based on repos
for REPO in "${REPOS[@]}"
do
    curl -k -H "Authorization: token $TOKEN" "https://api.github.com/repos/$OWNER/$REPO/commits?sha=$BRANCH&since=$SINCE&until=$UNTIL" | ./jq -r .[].commit.message > "$REPO"_Commits.txt
done

# Based on File Paths
# for PATH in "${FILEPATHS[@]}"
# do
#     curl -k -H "Authorization: token $TOKEN" "https://api.github.com/repos/$OWNER/$REPO/commits?sha=$BRANCH&path=$FILEPATH&since=$SINCE&until=$UNTIL" | ./jq -r .[].commit.message > "$REPO"_Commits.txt
# done

python process.py
