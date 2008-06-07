#!/bin/bash

# Wrapper around run-qemu.sh that sets up an ext3 image as a second virtual
# hard drive, then calls run-qemu.sh

# Default to image "hdb.img"

HDB="$1"
[ -z "$HDB" ] && HDB="hdb.img"

# Default size to create 2 gigabytes

HDBSIZE="$2"
[ -z "$HDBSIZE" ] && HDBSIZE=2048


# If we don't already have an hdb image, set up a 2 gigabyte sparse file and
# format it ext3.

if [ ! -e "$HDB" ]
then
  dd if=/dev/zero of="$HDB" bs=1024 seek=$[$HDBSIZE*1024-1] count=1
  mke2fs -b 1024 -F "$HDB"
  tune2fs -j -c 0 -i 0 "$HDB"
fi

export WITH_HDB="-hdb $HDB"

# Find the directory this script's running out of and call next script
"$(readlink -f "$(which $0)" | sed -e 's@\(.*/\).*@\1@')"run-emulator.sh