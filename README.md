# Download Bandwidth Control

This repository contains some experimens with shaping download speed on the client side.
This may come in handy to avoid saturating the server's bandwidth.

## Experimental setup

### Server

A simple [`iperf3`](https://iperf.fr) put in a docker container. Uses `--one-off` to terminate the container
as soon as the client is done benchmarking. No traffic shaping is happening server-side.

### Client

Also `iperf3` in a docker container, running with the `-R` flag to make it download data (instead of uploading).
