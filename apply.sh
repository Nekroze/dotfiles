#!/bin/sh
set -eux
variant="${1:-laptop}"
username=${2:-$USER}
nix-home --set --arg username "\"$username\"" --arg variant "\"$variant\""
