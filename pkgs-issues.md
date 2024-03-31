<details>
  <summary><strong>Error while updating</strong><hr /></summary>
  <h3>(something like "error: liburing: signature from ...")</h3>
  
```sh
sudo pacman -Sy archlinux-keyring
sudo pacman -Syyu
```

## Error upgrading due to conflicting files, or any other upgrade issue, check link below:

[Click for `pacman` arch wiki](https://wiki.archlinux.org/index.php/pacman)

<hr />
</details>
<details>
  <summary><strong>npm errors with upgrade</strong><hr/></summary>
  
```sh
npm uninstall -g npm
```

then re-ran `sudo pacman -Syyu`

<hr />
</details>
<details>
  <summary><strong>Bluetooth</strong><hr/></summary>
  
### Bluetooth setup:

-- pulseaudio-bluetooth pkg contains bluez && pulseaudio

`sudo pacman -S bluez-utils` <br />
`systemctl enable bluetooth.service` <br />

After this, try to reboot and go to `System Settings > Bluetooth`

If `+Add New Device...` is not an option, try below command.

`sudo pacman -S pulseaudio-bluetooth` <br />

Try to reboot again and check `System Settings > Bluetooth`

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
in `/etc/bluetooth/main.conf`, there are a lot of commented out commands. <br />
uncomment the varables in each respective section `[General]` and `[Policy]` <br />

```sh
[General]
DiscoverableTimeout = 0
Discoverable=true
[Policy]
AutoEnable=true
```

in `/etc/pulse/default.pa` <br />
`load-module module-switch-on-connect` <br />

### Bluetooth Display battery (sort of resolved):

Things I've done, not sure which one made it work:

see [Bluetooth_Headset_Battery_Level](https://github.com/TheWeirdDev/Bluetooth_Headset_Battery_Level).

(I don't remember how (or IF) I installed the equivalent of `python-pybluez`,
`python3-pybluez` or `python3-bluez` b/c after running
`pacman -Ss python3-pybluez` (and the same for the other two)
none showed they were installed.)

```sh
git clone git@github.com:TheWeirdDev/Bluetooth_Headset_Battery_Level.git
cd Bluetooth_Headset_Battery_Level
chmod +x bluetooth_battery.pyb
./bluetooth_battery.py <MAC_ADDRESS>
```

To get the desired MAC_ADDRESS, run `bluetoothctl devices`. <br />
My output is `Device C3:50:5B:21:9C:E9 dactylm45_left`.

e.g.:

```sh
git clone git@github.com:TheWeirdDev/Bluetooth_Headset_Battery_Level.git
cd Bluetooth_Headset_Battery_Level
chmod +x bluetooth_battery.pyb
./bluetooth_battery.py C3:50:5B:21:9C:E9
```

This output:

```sh
Couldn't find the RFCOMM port number
C3:50:5B:21:9C:E9 is offline [Errno 112] Host is down
```

So I followed the docs but kept getting the same output. <br />
I ran the Docker option first b/c I didn't remember successfully
installing the python-pybluez packages. The result was the same.

I also tried `upower -d` (`upower --dump`). <br />
If the battery level isn't already showing, then that device
will not be listed. After the battery level showed, that device
was on the list.

I ran `upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"`,
not sure what that does, but I found that in a blog or in
stackoverflow.

After running each of those, the battery level still did not
show up. I installed `acpi` and ran both `acpi` and `acpi -V`,
but I don't know much about `acpi`.

I went ahead and ran `sudo pacman -Syyu` b/c it was about time
to run it and after restarting, the battery level showed up.

The next day, I turn on the computer and no battery level. I
wake up the keyboard and run a few of the above and no status.
I restart, with the keyboard awake, and the battery level
showed.

So, not exactly sure which of the above (if any) worked.

~~For now, I'll just try to remember to wake the keyboard before turning on computer.~~

I woke keyboard before turning on computer, no battery level.
I plugged in keyboard, no battery, while computer shutting down,
I unplugged usb. <br />
I initially wake keyboard and turn on computer, no battery. <br />
With computer on and keyboard awake, reboot, and battery
level showed.

<hr />
</details>
<details>
  <summary><strong>Open window on monitor mouse is on</strong><hr/></summary>

Open window on same monitor as mouse:<br />
1.) System Settings<br />
2.) Window Management<br />
3.) Window Behavior<br />
4.) Click "Active screen follows mouse" in Multiscreen behavior section

<hr />
</details>
<details>
  <summary><strong>kdewallet popup's</strong><hr/></summary>

If kdewallet keeps showing up:<br />
(from arch linux docs, if using google-chrome aur)<br />
run `vim .config/chrome-flags.conf` and add `--password-store=basic`

<hr />
</details>
<details>
  <summary><strong>Virtualbox</strong><hr/></summary>

`sudo pacman -S virtualbox-host-dkms` not `virtual-host-modules-arch`. `virtual-host-modules-arch` did not have vboxdrv.

<hr />
  </details>
<details>
  <summary><strong>DisplayLink Failed, 2nd monitor not working</strong><hr /></summary>

Update displaylink and evdi-git in AURs, if package versions are out of date.<br/>
Last time the 2nd monitor was a black screen, both packages' versions were out of date
and I just ran the below and rebooted.

```sh
cd AURs/displaylink
cat PKGBUILD | grep pkgver
git pull
cat PKGBUILD | grep pkgver
makepkg -sic

cd ~/AURs/evdi-git
cat PKGBUILD | grep pkgver
git pull
cat PKGBUILD | grep pkgver
makepkg -sic
```

<hr />
</details>
