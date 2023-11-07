#!/bin/env bash
mainBranch=main
# finds all branches
branches=$(git branch | grep -v 'main')
# loop through branches, merge main, and push to remote origin
for branch in $branches; do
	git pull -ff
	git checkout $branch
	git merge --no-edit $mainBranch
	git push origin $branch
done


