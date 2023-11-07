#!/bin/env bash
mainBranch=main
# finds all branches
git branch | grep -v 'main'
branches=$(git branch | grep -v 'main')
echo $branches  
parallel \
	--dry-run \
	--jobs $(nproc) \
 	git pull \
  	git checkout {} \
  	git merge --no-edit $mainBranch \
  	git push :::  \
  	< <(echo "$branches")
# finish by checking out to main
git checkout $mainBranch
