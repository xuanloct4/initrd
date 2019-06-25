#!/bin/sh

echo "Pre Switch Root"

SWITCH_ROOT="/.overlay"
ROOT_INIT_RAM="/.root"
DEV_ROOT="$ROOT_INIT_RAM/dev"
SDB_ROOT="$SWITCH_ROOT"
SDB_ROOT_SQUASHFS="$SDB_ROOT/sdc1.sfs"
SDB_PRE_SWITCH_ROOT_SCRIPT="$SDB_ROOT/boot/scripts/pre_switch_root.sh"
TMPFS="/run"
OVERLAY="$SWITCH_ROOT"
OVERLAY_MNT="$SDB_ROOT/mnt"

# For persistent merged changes
OVERLAY_WORK_DIR="$SDB_ROOT/mnt/workdir/"
OVERLAY_UPPER="$SDB_ROOT/mnt/upper/"

# For temporary changes on ram fs
#OVERLAY_WORK_DIR="$TMPFS/workdir/"
#OVERLAY_UPPER="$TMPFS/upper/"

OVERLAY_LOWER="/.squashfs"


if ! [ -d "$ROOT_INIT_RAM" ]; then
	mkdir $ROOT_INIT_RAM
fi

if ! [ -d "$DEV_ROOT" ]; then
	mkdir $DEV_ROOT
fi

if ! [ -d "$SDB_ROOT" ]; then
	mkdir $SDB_ROOT
fi

if ! [ -d "$SWITCH_ROOT" ]; then
	mkdir $SWITCH_ROOT
fi

if ! [ -d "$OVERLAY" ]; then
	mkdir $OVERLAY
fi

if ! [ -d "$OVERLAY_MNT" ]; then
	mkdir $OVERLAY_MNT
fi

if ! [ -d "$OVERLAY_WORK_DIR" ]; then
	mkdir $OVERLAY_WORK_DIR
fi

if ! [ -d "$OVERLAY_UPPER" ]; then
	mkdir $OVERLAY_UPPER
fi

if ! [ -d "$OVERLAY_LOWER" ]; then
	mkdir $OVERLAY_LOWER
fi


if ! mount -n -t "$rootfstype" -o "$rootflags" "$device" $SDB_ROOT ; then
    no_mount $device
    cat /proc/partitions
    while true ; do sleep 10000 ; done
else
    echo "Successfully mounted device $root"
    echo "Content of $SDB_ROOT : "
    ls $SDB_ROOT -a
fi