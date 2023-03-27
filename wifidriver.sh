#!/bin/bash

# Build and enable proprietary MacBook Pro wifi driver #

echo "Build and enable proprietary MacBook Pro wifi driver"

lspci -k

rmmod b43 bcma ssb wl

modprobe wl

iw dev

iwlist wlan0 scan

echo "Move on to 'wpa.sh'"
