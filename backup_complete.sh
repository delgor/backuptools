#!/bin/bash

source ~/.backup.conf

${BACKUP_BASEDIR}/backup_databases.sh
${BACKUP_BASEDIR}/backup_files.sh
${BACKUP_BASEDIR}/upload.sh
echo "[BACKUP] Finished everything!"
