#!/bin/bash

HOME="/root/steamcmd"
APPDIR="/root/steamcmd/appdir"
RUNCMD="$APPDIR/gmod/srcds_run -console -game garrysmod"

# if mount cfg not there
if [ "$UPDATE" == "true" ] || [ "$UPDATE" == "TRUE" ] ; then
#if [ ! -f /root/steamcmd/appdir/gmod/garrysmod/cfg/mount.cfg ]; then
	echo "Validtion needed"
	sh /validate.sh
fi

if [ -z "$MAXPLAYERS" ]
then
	MAXPLAYERS=20
fi

RUNCMD="$RUNCMD +maxplayers \"$MAXPLAYERS\""

if [ -z "$MAP" ]
then
	MAP="gm_construct"
fi

RUNCMD="$RUNCMD +map \"$MAP\""

if [ -z "$GAMEMODE" ]
then
	GAMEMODE=sandbox
fi

RUNCMD="$RUNCMD +gamemode \"$GAMEMODE\""

if [ ! -z "$CONVARS" ]
then
        RUNCMD="$RUNCMD $CONVARS"
fi

if [ ! -z "$COLLECTION" ]
then
	if [ -z "$AUTHKEY" ]
	then
		echo "Error, cannot have a collection ID without Authkey"
		exit 0
	else
		RUNCMD="$RUNCMD -authkey \"$AUTHKEY\" +host_workshop_collection \"$COLLECTION\""
	fi
else
	echo "Collection not defined"

fi

$RUNCMD
