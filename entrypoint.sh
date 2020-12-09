#!/bin/sh

# Add strict errors.
set -eu

# Set deploy key
SSH_PATH="$HOME/.ssh"

# Create .ssh dir if it doesn't exist
mkdir -p "$SSH_PATH"

# Place deploy_key into .ssh dir
echo "${INPUT_SSH_PRIVATE_KEY}" > "$SSH_PATH/id_rsa"
chmod 600 "$SSH_PATH/id_rsa"

# rsync the data
sh -c "rsync ${INPUT_RSYNC_OPTIONS} -e 'ssh -i $SSH_PATH/id_rsa -o StrictHostKeyChecking=no' ${INPUT_SOURCE_FOLDER} ${INPUT_SSH_REMOTE_USER}@${INPUT_SSH_REMOTE_HOST}:${INPUT_TARGET_FOLDER}"
