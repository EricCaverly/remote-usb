#!/bin/bash

for BUS in "$@"; do
    usbip attach -r 127.0.0.1 -b $BUS
done
echo "attached" & sleep 1
usbip port
echo "connected,CTRL+C to exit"'
