#!/bin/sh
set -eux
variant="${1:-laptop}"
email="${2:-nekroze.lawson@gmail.com}"
username="${3:-$USER}"
nix-home --set \
	--arg username "\"$username\"" \
	--arg email "\"$email\"" \
	--arg variant "\"$variant\""
