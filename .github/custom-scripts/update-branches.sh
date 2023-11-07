#!/bin/env bash
mainBranch=main
# ensure main is committed and pushed and checkout to it
#git checkout $mainBranch
#git commit -am "updating branches"
# finds all branches
git branch | grep -v 'main'
branches=$(git branch | grep -v 'main')
echo $branches
parallel \
  --jobs $(nproc) \
  git pull \
  git checkout {} \
  git merge --no-edit $mainBranch \
  git push :::  \
  < <(echo "$branches")
# finish by checking out to main
git checkout $mainBranch
