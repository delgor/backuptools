#!/bin/bash

source ~/.backup.conf

echo "[BACKUP] transfer to ${1} started..."
rsync -v --recursive --delete "${BACKUP_TARGET}/" "${1}"
echo "[BACKUP] transfer to ${1} finished."
