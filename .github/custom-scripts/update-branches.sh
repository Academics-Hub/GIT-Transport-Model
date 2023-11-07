#!/bin/env bash
mainBranch=main
# finds all branches
branches=$(git branch | grep -v 'main')

function helper_git() {
	git pull
	git checkout "$1"
  	git merge --no-edit $mainBranch
	git push
}

parallel --jobs $(nproc) helper_git {} :::: <(echo "$branches")
# finish by checking out to main
git checkout $mainBranch
