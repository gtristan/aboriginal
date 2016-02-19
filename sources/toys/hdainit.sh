# splice hda into /
cp -rFs /usr/overlay/. /

# cleanup copy of _this_ script, and plug gcc so search stops

if [ -z "$DISTCC_HOSTS" ]
then
  echo "Not using distcc."
else
  echo "Distcc acceleration enabled."
  PATH="/usr/distcc:$PATH"
fi

if [ -e /mnt/init ]
then
  DO_HANDOFF="yes"
  if [ $BUILD_PAUSE -gt 0 ]
  then
    X=xx
    echo "Press any key for command line..."
    read -t $BUILD_PAUSE -n 1 X
    [ "$X" != xx ] && DO_HANDOFF="no"
  fi

  if [ "$DO_HANDOFF" == "yes" ]
  then
    echo "Running automated build."
    HANDOFF=/mnt/init
  fi
fi
