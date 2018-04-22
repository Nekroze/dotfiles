#!/bin/sh
set -euf

COMMIT="$(git rev-parse HEAD)"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
TARGET="laptop"
if [ "$BRANCH" != "master" ]; then
    TARGET="master"
fi

git checkout "$TARGET"
git cherry-pick "$COMMIT"
git push
git checkout "$BRANCH"
git push
