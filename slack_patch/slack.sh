#!/bin/bash

/usr/bin/slack &
PID=$!
ICON=/usr/local/bin/slack.png

# Wait slack to launch before attempting to modify it
until [ ! $(wmctrl -lp | grep $PID | cut -f1 -d' ' | xargs | grep -v "^$" | wc -l) = 0 ]
do
  sleep 2
done

# Find slack window(s) by name.
# You need to handle multiple windows here to actually get multiple workspaces working w/icons
WINDOWS=(`wmctrl -lp | grep $PID | cut -f1 -d' ' | xargs`)
echo $WINDOWS
for slack_window in ${WINDOWS[@]}; do
    xseticon -id ${slack_window} $ICON

    # Use "xprop" to set the window state, so that alt+tab works again
    xprop -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_NORMAL -id ${slack_window}
done
