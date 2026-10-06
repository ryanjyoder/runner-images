#!/usr/bin/env bash
set -euo pipefail

script_dir="$(dirname -- "${BASH_SOURCE[0]}")"
features_file="$script_dir/features.yaml"
temp_file="$(mktemp)"
mv "$features_file" "$temp_file"
features_file="$temp_file"

upstream_owner="actions"
upstream_repository="runner-images"
upstream_branch="main"
fork_default_branch="main"

if git remote get-url upstream >/dev/null 2>&1; then
  git remote set-url upstream https://github.com/${upstream_owner}/${upstream_repository}.git
else
  git remote add upstream https://github.com/${upstream_ownder}/${upstream_repository}.git
fi

git fetch upstream
git switch "$fork_default_branch"
git reset --hard "upstream/$upstream_branch"

for branch in $(yq -r '.branches[]' "$features_file"); do
  echo "Rebasing $branch onto main"
  git switch "$branch"
  git rebase main
  git push --force-with-lease
done

  git switch main

for branch in $(yq -r '.branches[]' "$features_file"); do
  echo "Merging $branch into main"
  git merge --no-ff "$branch" -m "Merge $branch"
done

git switch main
git push --force-with-lease
