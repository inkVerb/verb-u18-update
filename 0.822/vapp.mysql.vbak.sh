#!/bin/bash
# inkVerb donjon asset, verb.ink
## This script backs up all vapp MySQL databases


# Verify  backup structure
mkdir -p /var/local/verb/backups

# Backup each by vapp
cd /var/local/verb/configs
for f in vapp.*; do
/var/local/verb/serfs/mysqlvappout $f; wait
. /var/local/verb/configs/$f
mv ${APPDBASE} $f.sql
cp -f $f.sql /var/local/verb/backups/
rm -f $f.sql
done
