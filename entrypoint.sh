#!/bin/sh

# Start the SSH agent and load key.
source agent-start "$GITHUB_ACTION"
echo "$INPUT_REMOTE_KEY" | agent-add

# Add strict errors.
set -eu

# Set deploy key
SSH_PATH="$HOME/.ssh"

# Create .ssh dir if it doesn't exist
mkdir -p "$SSH_PATH"

# Place deploy_key into .ssh dir
echo "${SSH_PRIVATE_KEY}" > "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key"

# rsync the data
sh -c "rsync ${INPUT_RSYNC_OPTIONS} -e 'ssh -i $SSH_PATH/deploy_key -o StrictHostKeyChecking=no' ${GITHUB_WORKSPACE}${INPUT_SOURCE_FOLDER} ${SSH_REMOTE_USER}@${SSH_REMOTE_HOST}:${INPUT_TARGET_FOLDER}"
