## Slack patch

Slack doesn't show up in the Alt-Tab cycle, so let's fix it.

### How to use

```
./install.sh
```

### What does it do

1. Install some required programs
  - `wmctrl`: interact with X Window Manager
  - `xseticon`: sets the window icon for an X window
2. Create a new startup script and use it in the desktop file
