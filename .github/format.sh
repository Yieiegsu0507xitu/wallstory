#!/bin/bash

[[ -z "${GH_TOKEN}" ]] && echo "No gh token!" && exit 1

git config --global user.email "introdructor@gmail.com"
git config --global user.name "ykextrovert"

COMMIT_AUTHOR="$(git log -1 --pretty='%an <%ae>')"
COMMIT_MESSAGE="$(git log -1 --pretty=%B)"

for i in $(find . -type f -iname '*.json')
do
    jq . < $i > format.json
    mv format.json $i
done

if [[ -n "$(git status | grep "json")" ]]; then
    git add .
    git commit --amend -m "${COMMIT_MESSAGE}" --author="${COMMIT_AUTHOR}" --signoff
    git remote set-url origin "https://ykextrovert:${GH_TOKEN}@github.com/ykextrovert/file/"
    git push origin -f
fi
