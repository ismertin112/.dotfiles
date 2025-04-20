#!/bin/bash

TEMPLATE=/etc/resolv.conf.template
TARGET=/etc/resolv.conf

if [-f $TEMPLATE]; then
    cp "$TEMPLATE" "TARGET"
    echo "Fixing resolv.conf"
else
    echo "No template file"
    exit 1
fi

systemctl restart NetworkManager
