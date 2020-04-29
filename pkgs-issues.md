## AutoLogin
Autologin after screen sleep/off: <br />
1.) Go to System Settings <br />
2.) type `lock` in search <br />
3.) Go to Screen Locking <br />
4.) uncheck Lock screen: \_\_ Automatically After: 5 minutes <br />
## Bluetooth
Bluetooth: <br />
-- pulseaudio-bluetooth pkg contains bluez && pulseaudio

`sudo pacman -S bluez-utils` <br />
`systemctl enable bluetooth.service` <br />

`sudo pacman -S pulseaudio-bluetooth` <br />

connect: <br />
1.) `bluetoothctl` <br />
2.) `power on` <br />
3.) `agent on` <br />
4.) `default-agent` <br />
5.) `scan on` <br />
6.) `pair 3B:06:EF:35:58:A8` <--- whichever address you want to pair <br />
7.) `connect 3B:06:EF:35:58:A8` <br />

if connection for bluetooth fails: <br />
1.) Exit bluetoothctl <br />
2.) `pulseaudio -k` <br />
3.) `bluetoothctl` <br />
4.) `connect 3B:06:EF:35:58:A8` <br />

power Bluetooth adapter on after reboot: <br />
in /etc/bluetooth/main.conf, there are a lot of commented out commands. <br />
uncomment the varables in each respective section [General] and [Policy] <br />
`[General]` <br />
`DiscoverableTimeout = 0` <br />
`Discoverable=true` <br />
`[Policy]` <br />
`AutoEnable=true` <br />

in /etc/pulse/default.pa <br />
`load-module module-switch-on-connect` <br />
## Open window on monitor mouse is on
Open window on same monitor as mouse:<br />
1.) System Settings
2.) Window Management
3.) Window Behavior
4.) Click "Active screen follows mouse" in Multiscreen behavior section
## kdewallet popup's
If kdewallet keeps showing up:<br />
(from arch linux docs, if using google-chrome aur)<br />
run `vim .config/chrome-flags.conf` and add `--password-store=basic`
## external usb
`sudo pacman -S ntfs-3g`<br />
restart <br />
(prior to restarting, I had tried several things like: <br />
`sudo pacman -S udisks2` and <br />
immediately after `sudo pacman -S ntfs-3g` then `mount /dev/sdb1 /mnt/usb` ... be sure to `sudo mkdir /mnt/usb` first... then restart)
## Docker without sudo
Instead of `sudo docker ps`, add user to docker group by running `sudo gpasswd -a <user> <group>`<br />
(e.g. `sudo gpasswd -a justin docker`)<br />
then, reboot and now run `docker ps`.
