#!/bin/sh
set -euf
COMMIT="$(git rev-parse HEAD)"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
TARGET="laptop"
if [ "$BRANCH" != "master" ]; then
    TARGET="master"
fi
echo
echo "BRANCH: $BRANCH"
echo
git pull --rebase
git push
echo
echo "BRANCH: $TARGET"
echo
git checkout "$TARGET"
git pull --rebase
git cherry-pick "$COMMIT"
git push
git checkout "$BRANCH"
