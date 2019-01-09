#!/usr/bin/env bash
#?
# start-nvim.sh - Changes to the $GOTO_DIR directory and runs nvim
#
# USAGE
#	start-nvim.sh NVIM_ARGS...
#
# ARGUMENTS
#
#	1. NVIM_ARGS...    Argument to pass to Neovim
#
# BEHAVIOR
#
#	Changes to the $GOTO_DIR path inside of the /home/shared/working-dir 
#	directory.
#
#	This allows the entire host file system to be traversed inside of the 
#	Docker container.
#
#	If an absolute file path is provided in NVIM_ARGS the first slash is 
#	removed so that files inside the /home/shared/working-dir directory are
#	opened. Instead of files inside the Docker container.
#
#?

WRKING_DIR="/h/"

# Check GOTO_DIR environment variable is provided
if [ -z "$GOTO_DIR" ]; then
	echo "Error: GOTO_DIR environment variable must not be empty" >&2
	exit 1
fi

# Move into the container working directory, where the host file system will
# be mounted. Then move into the directory in the host file system which the 
# script was invoked from.
cd "$WRKING_DIR$GOTO_DIR"

# Modify absolute paths if provided in arguments
new_args=()
for arg in "$@"; do
	# If absolute path
	if [[ "$arg" =~ /.* ]]; then
		new_args+=("$WRKING_DIR${arg}")
	else
		new_args+=("$arg")
	fi
done

# Execute Neovim
nvim "${new_args[*]}"
