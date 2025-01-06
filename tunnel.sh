#!/bin/bash

# USB ID of device to forward
IDS=("16d0:0567" "0403:6014")
BUSES=( )

# Server (Actually USBIP Client) Information
USR="root"
REMOTE="10.0.10.40"

echo -e "---[LOCAL]---"
# For each ID, do the following
for ID in "${IDS[@]}"; do
    echo -e "Looking for USB: $ID"
    # Find the USBIP Bus of the device
    BUS=$(sudo usbip list -pl | grep $ID | sed -n 's/.*busid=\([^#]*\).*/\1/p' )

    if [[ $BUS -ne "" ]]; then
        # Inform the user of the BUS
        echo -e "Forwarding [$BUS]"

        # Bind the bus to this computer
        BUSES+=($BUS)
        sudo usbip bind -b $BUS
    else
        echo -e "Device $ID not connected..."
    fi
done

if [[ ${#BUSES[@]} -eq 0 ]]; then
    echo -e "No devices found"
    exit 1
fi

# Remote into the remote computer, while forwarding the local USBIP server (TCP/3240) to the remote server (which can then access it on 127.0.0.1:3240)
# Immediately run the command to attach the USB device on the BUS found before available at localhost (which ends up being the port forwarded from this computer)
# Wait 1 second for the connection to be formed. Show a connected message, ports connected, and inform the user how to exit
echo -e "---[SERVER]---"

ssh -R localhost:3240:127.0.0.3:3240 $USR@$REMOTE "curl -sSL https://raw.githubusercontent.com/EricCaverly/remote-usb/refs/heads/main/remote.sh | bash -s -- ${BUSES[@]}"

echo -e "---[LOCAL]---"
# Unbind the USB port from this computer
for BUS in "${BUSES[@]}"; do
    sudo usbip unbind -b $BUS
done
