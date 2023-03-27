#!/bin/bash

#Setting up network connection via wpa_supplicant

# Define a function to get user info
get_user_info() {
    read -p "Please enter your wifissid: " wifissid
    if [[ -z "$wifissid" ]]; then
        echo "Error: wifissid cannot be empty"
        exit 1
    fi

    read -p "Please enter your wifipassword: " wifipassword
    if [[ "-z $wifipassword" ]]; then
        echo "wifipassword accepted"
    else
        echo "Error: wifipassword cannot be empty."
        exit 1
    fi
}

# Call the function to get user info
get_user_info

echo "Setting wpa_supplicant"

wpa_passphrase ‘$wifissid’ ‘$wifipassword’ » /etc/wpa_supplicant/wpa_supplicant.conf
wpa_supplicant -Bc /etc/wpa_supplicant/wpa_supplicant.conf -i 'wlan0'

echo "Try to ping google.com If successful, move to next step."
