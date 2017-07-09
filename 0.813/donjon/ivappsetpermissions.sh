#!/bin/sh
# inkVerbDragon, verb.ink

# This sets permissions for users created by ivApp
## This is necessary since directory permissions can create errors that need to be quited and ignored, without interfering with outher needed error reporting

# How to use:
## ./ivappsetpermissions.sh


CONF=$1
ADDIVAPPUSERNAME=$2


# Include configs
. ${CONF}
. ${IVAPPCONFLOC}

### Note: we add " > /dev/null 2>&1" because this may kick output errors that don't matter and filibuster other important messages.
setfacl -R -m user:${ADDIVAPPUSERNAME}:--- /home > /dev/null 2>&1
setfacl -R -m user:${ADDIVAPPUSERNAME}:--- /var > /dev/null 2>&1
setfacl -R -m user:${ADDIVAPPUSERNAME}:--- ${IVAPPBASE} > /dev/null 2>&1
setfacl -R -m user:${ADDIVAPPUSERNAME}:rwx ${IVAPPBASE}/${IVAPPDIR}/${IVAPPGROUPDIR}/${ADDIVAPPUSERNAME} > /dev/null 2>&1

