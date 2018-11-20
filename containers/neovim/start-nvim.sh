#!/usr/bin/env sh
#?
# start-nvim.sh - Changes to the $GOTO_DIR directory and runs nvim
#
# USAGE
#	start-nvim.sh NVIM_ARGS...
#
# BEHAVIOR
#
#	Changes to the $GOTO_DIR path inside of the /home/shared/workdir 
#	directory.
#
#	This allows the entire host file system to be traversed inside of the 
#	Docker container.
#?
if [ -z "$GOTO_DIR" ]; then
	echo "Error: GOTO_DIR environment variable must not be empty" >&2
	exit 1
fi

cd "/h$GOTO_DIR"
nvim "$@"
