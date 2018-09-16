#!/bin/sh
set -eux
variant="${1:-laptop}"
username="${2:-$USER}"
email="${3:-nekroze.lawson@gmail.com}"
nix-home --set \
	--arg username "\"$username\"" \
	--arg email "\"$email\"" \
	--arg variant "\"$variant\""
