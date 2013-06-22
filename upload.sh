#!/bin/bash

source ~/.backup.conf

REMOTE_MOUNT="/path/to/mount"
REMOTE_PATH="/backup"

sshfs user@hostname: "${REMOTE_MOUNT}"
${BACKUP_BASEDIR}/transfer.sh "${REMOTE_MOUNT}${REMOTE_PATH}"
fusermount -u "${REMOTE_MOUNT}"


