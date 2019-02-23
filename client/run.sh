#!/bin/sh

echo "Executing traffic shaping experiment: $EXPERIMENT"

./tc/$EXPERIMENT.sh || exit 1

iperf3 -c $SERVER -p $PORT -f K -R

