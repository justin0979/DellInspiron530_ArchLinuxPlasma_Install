#!/bin/bash

#xsetwacom set 'Wacom Cintiq 16 Pen stylus' MapToOutput DVI-I-1-2
#xsetwacom set 'Wacom Cintiq 16 Pen eraser' MapToOutput DVI-I-1-2

DEVICES="stylus eraser"
# MONITOR="DVI-I-1-2" # ONLY choose one monitor
MONITOR="VGA-1"       # ONLY choose one monitor

for DEVICE in $DEVICES
do
  (xsetwacom set "Wacom Cintiq 16 Pen ${DEVICE}" MapToOutput $MONITOR &&
    echo "Wacom Cintiq 16 Pen ${DEVICE} SET to ONLY ${MONITOR} monitor") || exit 1
done



# Run: xsetwacom list devices
# Output:
#   Wacom Cintiq 16 Pen stylus     id: 8   type: STYLUS
#   Wacom Cintiq 16 Pen eraser     id: 11  type: ERASER
#
# Run: xev -event button
# Output:
#   Opens window to identify ButtonPress events so that you can find button number to map

# To re-map buttons, run the following:
#   xsetwacom set <pad-or-stylus> Button <number> <keyword> <arguments>
#      <pad-or-stylus> refers to the id provided from `xsetwacom list devices`.
#      <number> refers to button number given after running `xev -event button`.
#      <keyword> refers to what the button is being mapped to.

# To re-map side button closest to nib:
NUMBERS=$(xsetwacom list devices | grep stylus | tr -d -c 0-9) # This gets only number. (e.g., outputs: 168)
ID=${NUMBERS:2} # Removes first two digits. (if NUMBERS=168, then this outputs: 8)

# set button 2 to have button 3's function
xsetwacom set ${ID} Button 2 Button 3 && xsetwacom set ${ID} Button 3 pan && echo "Stylus Button 2 set to pan"
