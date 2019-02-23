#!/bin/sh

echo "Setting up naive 8mbit tc"
set -x


tc qdisc add dev eth0 handle ffff: ingress
tc filter add dev eth0 parent ffff: u32 match u32 0 0 police rate 8mbit burst 64k drop

