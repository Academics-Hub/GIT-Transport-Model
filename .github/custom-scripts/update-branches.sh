#!/bin/env bash
function helper_git() {
	git pull
	git checkout "$1"
  	git merge --no-edit $mainBranch
	git push
}
mainBranch=main
branches=$(git branch | grep -v 'main')
parallel --jobs $(nproc) helper_git {} :::: <(echo "$branches")
git checkout $mainBranch
