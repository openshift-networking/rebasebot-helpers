#!/bin/bash

set -o nounset
set -o pipefail
set -o xtrace

git status
git diff
git add .
git commit -m "UPSTREAM: <carry>: rebasebot: update OCP manifests"
