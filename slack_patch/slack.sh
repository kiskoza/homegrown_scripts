#!/bin/bash

/usr/bin/slack &

ICON=/usr/lib/slack/resources/app.asar.unpacked/src/static/slack.png

# Give slack enough time to launch before attempting to modify it
sleep 10

# Find slack window(s) by name.
# You need to handle multiple windows here to actually get multiple workspaces working w/icons
WINDOWS=(`wmctrl -l | grep "Slack - " | cut -f1 -d' ' | xargs`)
for slack_window in ${WINDOWS[@]}; do
    xseticon -id ${slack_window} $ICON

    # Use "xprop" to set the window state, so that alt+tab works again
    xprop -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_NORMAL -id ${slack_window}
done
