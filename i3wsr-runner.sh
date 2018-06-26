#!/bin/sh
set -euf

function silently(){
    "$@" > /dev/null 2>&1
}

function i3_is_running() {
	local attempts="${1:-5}"
	until [ "$attempts" -le 0 ]; do
		silently pgrep i3 && return 0
		echo "i3 is not running, retrying in 1 second..."
		sleep 1
		attempts=$[$attempts-1]
	done
	echo "Cannot use i3wsr without i3, stopping."
	return 1
}

if ! i3_is_running; then
	exit 0
fi

echo "Launching i3wsr."
i3wsr
exit 1
