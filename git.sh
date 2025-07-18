#!/bin/bash

set -o nounset
set -o pipefail
set -o xtrace

git status
git diff --exit-code ':(exclude)manifests/stable/manifests/kubernetes-nmstate-operator.clusterserviceversion.yaml'
if [ $? -eq 0 ]
then
  echo "No changes besides csv found."
  git diff --exit-code --ignore-matching-lines='^.*createdAt: "[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z"' manifests/stable/manifests/kubernetes-nmstate-operator.clusterserviceversion.yaml
  if [ $? -eq 0 ]
  then
    echo "No changes besides createdAt: found. Aborting."
  else
    echo "Changes in csv found that aren't createdAt."
    echo "Committing changes."
    git add .
  fi
else
  echo "Committing changes."
  git add .
fi

# When there is nothing to commit, the following will return 1.
# Because we do not care about no-changes situation, just ignore it.
git commit -m "UPSTREAM: <carry>: rebasebot: update OCP manifests and fix golang deps" || true
