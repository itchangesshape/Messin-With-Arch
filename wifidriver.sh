#!/bin/bash

# Build and enable proprietary MacBook Pro wifi driver #

echo "Build and enable proprietary MacBook Pro wifi driver"

lspci -k

rmmod b43 bcma ssb wl

modprobe wl

iw dev

ifconfig wlan0 up

iwlist wlan0 scan

wpa_passphrase ‘WIFINETWORK’ ‘WIFIPASSWORD’ » /etc/wpa_supplicant/wpa_supplicant.conf

wpa_supplicant -Bc /etc/wpa_supplicant/wpa_supplicant.conf -i ‘wlan0’

echo "Try ping now"
