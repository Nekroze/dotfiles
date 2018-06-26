#!/bin/sh
set -euf

function silently(){
    "$@" > /dev/null 2>&1
}

function i3_is_running() {
	local attempts="${1:-5}"
	until [ "$attempts" -le 0 ]; do
		silently pgrep i3 && return 0
		sleep 1
		attempts=$[$attempts-1]
	done
	return 1
}

if ! i3_is_running; then
	exit 0
fi

i3wsr
exit 1
