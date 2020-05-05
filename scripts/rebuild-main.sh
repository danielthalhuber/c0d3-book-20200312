#!/bin/bash

# helper function for formatting numbers as strings with leading zeros
pad_number() {
  number=$1
  pad_count=$2
  printf %0"$pad_count"g "$number"
}

# set the challenge counts
challenge_counts=(10 12 11 10)

# ensure that we're not on the main branch and then remove it
git checkout master
git branch -D main

# create a new main from master
git checkout -b main

# merge challenge branches into main, grouping the merge by lesson
for i in ${!challenge_counts[*]}
do
  lesson="js$(pad_number "$i" 2)"
  challenge_count=${challenge_counts[$i]}
  branches=()

  # collect all the branch names and then merge the branches
  for ((c=1; c<=$challenge_count; c++))
  do
    branch_name="js$(pad_number "$i" 2)c$(pad_number "$c" 2)"
    branches+=("$branch_name")

    if [ "$c" -eq "$challenge_count" ]
    then
      git merge "${branches[@]}" -m "\"merge ${lesson} challenge branches into main\""
    fi
  done
done

# merge the util branch
git merge util -m "merge util branch into main"