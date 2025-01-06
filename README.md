## What does this do?
Allows you to specify multiple USB IDs to forward to a remote linux computer through a reverse SSH connection.

## Why did I write this script?
For school (Computer Engineering Technologies @ NAIT) I needed to use many outdated hardware components that only work with also outdated software counterparts. These include FreeScale Code Warrior, Lab view, etc.

As I am an avid Linux user this was not going to fly. Originally my solution was a Windows 11 VM, but that caused my CPU on my poor Lenovo Thinkpad to reach oven pre-heat temps. Instead I made a Windows Server 2022 VM on Proxmox, and wrote this script to forward USB connections into the Proxmox server where they could be attached to the Windows VM.

## How do I use it?
1. Install USBIP on both your Linux devices
2. Only start the service on your laptop (or device that will have USB devices attached)
3. Modify the `tunnel.sh` script for your needs
    - Use `lsusb` to find the ID of USB devices you wish to forward. Put these into the `$IDS` array
    - Set the `$USR` and `$REMOTE` variables to the username on the remote linux box and its IP address / hostname 
4. Run the script with `./tunnel.sh` 

> For more info follow the PDF guide uploaded in this repo. IMPORTANT: THE BASH INSIDE THE PDF IS FOR A SIMPLER VERSION
