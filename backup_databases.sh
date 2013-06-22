#!/bin/bash
# TARGET: Where to store the database dumps. Uses plain SQL files.
# IGNORE: List of databases not to be dumped. Separated by "|"
# CONF: Needs to contain valid login credentials.
TARGET=/where/to/store/the/database/dumps
IGNORE="phpmyadmin|mysql|information_schema|performance_schema|test"
CONF=/path/to/mysql.conf

if [ ! -r $CONF ]; then /usr/bin/logger "$0 - auf $CONF konnte nicht zugegriffen werden"; exit 1; fi
if [ ! -d $TARGET ] || [ ! -w $TARGET ]; then /usr/bin/logger "$0 - Backup-Verzeichnis nicht beschreibbar"; exit 1; fi

DBS="$(/usr/bin/mysql --defaults-extra-file=$CONF -Bse 'show databases' | /bin/grep -Ev $IGNORE)"
NOW=$(date +"%Y-%m-%d")

for DB in $DBS; do
    /usr/bin/mysqldump --defaults-extra-file=$CONF --skip-extended-insert --skip-comments $DB > $TARGET/$DB.sql
done

# Possible connection to version control - we don't use this, since our file backup uses diffs.

#if [ -x /usr/bin/bzr ] && [ -d ${TARGET}/.bzr/branch ]; then
#  cd $TARGET
#  /usr/bin/bzr add .
#  /usr/bin/bzr commit -m "$NOW"
#else
#  /usr/bin/logger "$0 - bzr nicht verfuegbar oder Backup-Ziel nicht unter Versionskontrolle"
#fi

echo "$0 - Backup von $NOW erfolgreich durchgefuehrt"
exit 0
