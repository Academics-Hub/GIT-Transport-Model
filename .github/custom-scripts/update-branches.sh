#!/bin/env bash
mainBranch=main
# ensure main is committed and pushed and checkout to it
git checkout $mainBranch
git commit -am "updating branches"
# finds all branches
branches=$(git branch | grep -v 'main')
# loop through branches, merge main, and push to remote origin
for branch in $branches; do
	git pull -ff
	git checkout $branch
	git merge --no-edit $mainBranch
	git push origin $branch
done
# finish by checking out to main
git checkout $mainBranch
