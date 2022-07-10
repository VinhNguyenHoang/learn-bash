#!/bin/bash
set -e
soulUltraAddr=""

# if device is not connected
if bluetoothctl -- info $soulUltraAddr | grep 'Connected: no' > /dev/null; then
    # start connect
    bluetoothctl -- connect $soulUltraAddr
    if [ "${PIPESTATUS[0]}" -ne "0" ]; then
        echo "Error connecting Soul Ultra Wireless"
    fi
else # disconnect
    bluetoothctl -- disconnect $soulUltraAddr
    if [ "${PIPESTATUS[0]}" -ne "0" ]; then
        echo "Error disconnecting Soul Ultra Wireless"
    fi
fi
