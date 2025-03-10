#!/bin/bash

set -o nounset
set -o pipefail
set -o xtrace

git status
git diff
git add .

# When there is nothing to commit, the following will return 1.
# Because we do not care about no-changes situation, just ignore it.
git commit -m "UPSTREAM: <carry>: rebasebot: update OCP manifests" || true
