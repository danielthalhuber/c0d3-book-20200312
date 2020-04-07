#!/bin/bash

# set the challenge counts
challenge_counts=(10 12)

# determine the remote repository
remote=$1
if [ -z "$remote" ]
then
  remote="origin"
fi

# determine the current/starting branch
starting_branch=$(git rev-parse --abbrev-ref HEAD)

# helper function for formatting numbers as strings with leading zeros
pad_number() {
  number=$1
  pad_count=$2
  printf %0"$pad_count"g "$number"
}

# push the local dev branches to the remote repo
for i in ${!challenge_counts[*]}
do
  for ((c=1; c<=${challenge_counts[$i]}; c++))
  do
    branch_name="js$(pad_number "$i" 2)c$(pad_number "$c" 2)"
    git checkout "$branch_name" && git push --force -u "$remote" "$branch_name"
  done
done

# return to the starting branch
git checkout "$starting_branch"
