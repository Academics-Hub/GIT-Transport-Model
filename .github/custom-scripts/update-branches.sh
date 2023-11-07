#!/bin/env bash
git pull
function helper_git() {
	git pull
	git checkout "$1"
  	git merge --no-edit $mainBranch
	git push
}
export -f helper_git
mainBranch=main
git branch | grep -v 'main'
branches=$(git branch | grep -v 'main')
echo "$branches"
#parallel  -j8 helper_git {} :::: <(echo "$branches")
git checkout $mainBranch
