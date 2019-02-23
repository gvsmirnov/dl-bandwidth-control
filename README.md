# Download Bandwidth Control

This repository contains some experimens with shaping download speed on the client side.
This may come in handy to avoid saturating a server's bandwidth and affecting other clients.

## Experimental setup (docker)

### Server

A simple [`iperf3`](https://iperf.fr) put in a docker container. Uses `--one-off` to terminate the container
as soon as the client is done benchmarking. No traffic shaping is happening server-side.

### Client

Also `iperf3` in a docker container, running with the `-R` flag to make it download data (instead of uploading).
Before the perf test is initiated, some traffic shaping commands are executed, mostly using [`tc`](http://tldp.org/HOWTO/Traffic-Control-HOWTO/index.html).
To make `tc` run in docker, the [`NET_ADMIN`](http://man7.org/linux/man-pages/man7/capabilities.7.html)
capability must be [added](https://docs.docker.com/compose/compose-file/#cap_add-cap_drop).


## Experimental setup (not docker)

Make sure that `iperf3` and `iproute` packages are installed on the host, then execute the `run.sh` scripts, setting the required env variables.

## Shaping exercises

Are located in the `client/tc` folder. Each experiment is explained in greated detail in the appropriate file's contents.

