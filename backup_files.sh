#!/bin/bash

source ~/.backup.conf

PWD=`pwd`
cd ${BACKUP_BASEDIR}
echo "[BACKUP] doing local file backup..."
export PASSPHRASE=${PASSPHRASE}
# volsize can be adjusted to create volumes of different size. Value in MB
duplicity -v4 --exclude-globbing-file=files.list --volsize=500 / file://${BACKUP_TARGET}
unset PASSPHRASE
echo "[BACKUP] local backup finished."
cd ${PWD}
