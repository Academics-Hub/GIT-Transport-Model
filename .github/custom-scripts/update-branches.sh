#!/bin/env bash
function helper_git() {
	git pull
	git checkout "$1"
  	git merge --no-edit $mainBranch
	git push
}
export -f helper_git
mainBranch=main
branches=$(git branch | grep -v 'main')
parallel  -j8 helper_git {} :::< <(echo "$branches")
git checkout $mainBranch
