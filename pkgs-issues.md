Autologin after screen sleep/off:
1.) Go to System Settings
2.) type `lock` in search
3.) Go to Screen Locking
4.) uncheck Lock screen: \_\_ Automatically After: 5 minutes

Bluetooth:
-- pulseaudio-bluetooth pkg contains bluez && pulseaudio

`sudo pacman -S bluez-utils`
`systemctl enable bluetooth.service`

`sudo pacman -S pulseaudio-bluetooth`

connect:
1.) `bluetoothctl`
2.) `power on`
3.) `agent on`
4.) `default-agent`
5.) `scan on`
6.) `pair 3B:06:EF:35:58:A8` <--- whichever address you want to pair
7.) `connect 3B:06:EF:35:58:A8`

if connection for bluetooth fails:
1.) Exit bluetoothctl
2.) `pulseaudio -k`
3.) `bluetoothctl`
4.) `connect 3B:06:EF:35:58:A8`

power Bluetooth adapter on after reboot:
in /etc/bluetooth/main.conf, there are a lot of commented out commands.
uncomment the varables in each respective section [General] and [Policy]
`[General]`
`DiscoverableTimeout = 0`
`Discoverable=true`
`[Policy]`
`AutoEnable=true`

in /etc/pulse/default.pa
`load-module module-switch-on-connect`

For PDF:
`pacman -S okular`
