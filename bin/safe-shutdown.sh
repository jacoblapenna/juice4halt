#!/usr/bin/env bash

# This script runs if the juice4halt.service stops (e.g., if the reboot command is called).
set -eo pipefail

# If flag file is present (created by watchdog), watchdog.sh handles shutdown from J4H signal
FLAG=/home/pi/juice4halt/.triggered-shutdown
if test -f "$FLAG"; then
    echo "$FLAG exists."
    echo "Shutdown was requested by juice4halt watchdog."
    exit 0
fi

# Otherwise, send a signal to the J4h that puts in it the proper state for restarting
# A LOW to HI signal tells the J4H to shutdown
echo "Setting juice4halt module into safe shutdown mode..."

# Force LOW to HI transition on the GPIO25 line
pinctrl 25 op dl
sleep 0.1s
pinctrl 25 ip

echo "juice4halt in safe shutdown mode. Machine can now be powered off."
