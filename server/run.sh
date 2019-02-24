#!/bin/sh

trap finish SIGTERM SIGINT

function finish {
    kill -SIGTERM $IPERF3_PID
}

iperf3 -s -f K --one-off &
IPERF3_PID=$!

wait $IPERF3_PID
