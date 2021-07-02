<details>
  <summary><h3>Error while updating</h3><hr /></summary>
  <h3>(something like "error: liburing: signature from ...")</h3>
  
```sh
sudo pacman -Sy archlinux-keyring
sudo pacman -Syyu
```

## Error upgrading due to conflicting files, or any other upgrade issue

[Click for `pacman` arch wiki](https://wiki.archlinux.org/index.php/pacman)

</details>
<details>
  <summary>npm errors with upgrade<hr/></summary>
  
```sh
npm uninstall -g npm
```

then re-ran `sudo pacman -Syyu`

</details>
<details>
  <summary>Reminder for ethernet access on Dell Inspiron laptop<hr /></summary>
  
Get interface with `ip addr`<br />
Then run `sudo ip link set <intertace> up` e.g. `sudo ip link set enp9s0 up`<br />
Then ping a site.

 </details>
 <details>
   <summary>AutoLogin<hr/></summary>
  
Autologin after screen sleep/off: <br />
1.) Go to System Settings <br />
2.) type `lock` in search <br />
3.) Go to Screen Locking <br />
4.) uncheck Lock screen: \_\_ Automatically After: 5 minutes <br />

</details>
<details>
  <summary>Bluetooth<hr/></summary>
  
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

```sh
[General]
DiscoverableTimeout = 0
Discoverable=true
[Policy]
AutoEnable=true
```

in /etc/pulse/default.pa <br />
`load-module module-switch-on-connect` <br />

</details>
<details>
  <summary>Open window on monitor mouse is on<hr/></summary>
  
Open window on same monitor as mouse:<br />
1.) System Settings<br />
2.) Window Management<br />
3.) Window Behavior<br />
4.) Click "Active screen follows mouse" in Multiscreen behavior section

</details>
<details>
  <summary>kdewallet popup's<hr/></summary>
  
If kdewallet keeps showing up:<br />
(from arch linux docs, if using google-chrome aur)<br />
run `vim .config/chrome-flags.conf` and add `--password-store=basic`

</details>
<details>
  <summary>external usb<hr/></summary>
  
Install `ntfs-3g`:<br />
`sudo pacman -S ntfs-3g`<br />
restart <br />
make usb directory:<br />
`sudo mkdir /mnt/usb`<br />
locate usb device with `lsblk`, `df -h`, or some other method.  
For me, I see 
```sh
sdb
|
--sdb1
```
mount device from location given by `lsblk` (or whichever method you use):<br />
`sudo mount /dev/sdb1 /mnt/usb`<br />
Access the usb in `/mnt/usb`

</details>
<details>
  <summary>Docker without sudo<hr/></summary>
  
Instead of `sudo docker ps`, add user to docker group by running `sudo gpasswd -a <user> <group>`<br />
(e.g. `sudo gpasswd -a justin docker`)<br />
then, reboot and now run `docker ps`.

  </details>
<details>
  <summary>Virtualbox<hr/></summary>
  
`sudo pacman -S virtualbox-host-dkms` not `virtual-host-modules-arch`. `virtual-host-modules-arch` did not have vboxdrv.

  </details>
<details>
  <summary>gimp screenshot<hr/></summary>
  
Instead of just running `gimp` from command line, run<br />`dbus-launch gimp`<br />
then go to File >> Create >> Screenshot

  </details>
<details>
  <summary>minikube<hr/></summary>
  
```sh
minikube start
```
```sh
minikube status
```
if get `machine does not exist` or `Error: No such container: minikube` then run:
```sh
minikube delete
```
and then 
```sh
minikube start
```
again.

  </details>
