# Arch Linux Installation onto Dell Inspiron 530

A reference for me later (on a 2007-2008 desktop). I randomly update some of the text here, so
some specs will be mismatched in places.<br />
Also, files like `pkgs_issues.md` and `reminders_tips.md` contain similar topics b/c I have not
gotten around to organizing those (and all the other) files.<br />
I use this as my main computer. Occasionally get stuck during booting after an update and if
I can't find a solution, I'll just re-install b/c it does not take long at all.

<details>
 
<summary><strong> Specs </strong><hr /></summary>

Motherboard: G33M03 <br />
~~RAM: 3GB (2 x 1GB DDR2 800 MHz, 2 x 512MB DDR2 800 MHz)~~ (Upgraded)<br />
CPU: Intel(R) Core(TM)2 Quad CPU Q6600 @ 2.40GHz <br />
~~GPU: AMD (don't remember specs)~~ (Upgraded)<br />
Architecture: x86_64 <br />
Power Supply: 350W <br />

</details>

<details>
 
<summary><strong> Upgrades </strong><hr /></summary>

500 GB Samsung 860 SSD (from 1TB HDD, I think 1TB or 500GB) <br />
uBit wifi 6 PCI-e card with bluetooth. <br />
NVIDIA Corporation GF119 [GeForce GT 610] <br />
RAM: 8GB (cheap 2GB sticks from Amazon)

</details>

### I chose Arch Linux b/c it was one of the distros to use a 5.1+ (5.10.81-1-lts, at time of install and as of November 24, 2021) kernel, which Intel states is required for wifi ax cards.

### After a lot of pain and closely, but not comprehensively, reading the ArchWiki docs, I was able to finally boot to a lighter weight plasma-desktop. I re-did the install 2 more times to ensure I started to understand some of what I was doing. I then went ahead and just installed full Plasma. The Dell handles this desktop environment very well. I have a dual monitor setup, and plasma came with everything to get me up and running. At the time of my initial install, Plasma-desktop didn't come with "out-of-the-box" dual monitor working (or at least one of the packages didn't).

## There could be several typos here.

Like I said, the following steps are reference for what I did to get this Dell working.

I followed the docs about 95-99% and some youtube videos (about 1%) that expalained the docs (hence some of the commands being in a slightly different order than the docs).

The docs link to other pages for more detail and it was very easy to miss a link (I missed the boot loader part) or to just not understand what an entire section was talking about. If it wasn't for some youtube videos, I would have missed some of the commands I needed to use. But, after spending more time reading the doc's for setting things up like `iptables`, the doc's ARE the only source you need to use for anything.

UEFI has only a slightly different method than what follows, I believe I used UEFI in the [thinkpadarch.md](https://github.com/justin0979/DellInspiron530_ArchLinuxPlasma_Install/blob/main/thinkpadarch.md) for my laptop.

I used `dd` to get a usb iso and booted that way. Here is one guide,
[How to Create Bootable USB Drive Using dd Command](https://linuxiac.com/how-to-create-bootable-usb-drive-using-dd-command/) I found online, not sure if I followed this one back then though.

Here's the link to [Arch Linux Downloads](https://archlinux.org/download/)

### Boot from usb:

Just plug it in and hit `f12` or whichever key gets you into the bootloader.

### Set up internet connection with `iwd`:

```
root@archiso ~ # systemctl enable --now systemd-networkd systemd-resolved iwd
root@archiso ~ # networkctl status -a
```

See [systemd-networkd 1.3.3 Wireless adapter](https://wiki.archlinux.org/title/Systemd-networkd#Wireless_adapter)

Create new file `20-wireless.network`:

```
root@archiso ~ # vim /etc/systemd/network/20-wireless.network
```

In `20-wireless.network`, enter `insert` mode by pressing `i`:

```sh
# In /etc/systemd/networkd/20-wireless.network

[Match]
Name=wlan0

[Network]
DHCP=yes
```
To exit `insert` mode, press `ctrl-c` (press and hold `ctrl` and then press `c` while still holding `ctrl`).<br/>
Save and close the file by typing `:` followed by `w` then `q` followed by `<enter>`.

[Arch linux iwd link](https://wiki.archlinux.org/title/Iwd#iwctl)<br />
Now the interactive prompt can be accessed with `iwctl` and the wifi device (`wlan0` from above) and network 
name can be set (whatever you wifi network's name is):

```
root@archiso ~ # iwctl
[iwd]# station wlan0 connect YourWifiNameGoesHere
[iwd]# exit
```

Also, `wifi-menu` can still be used also, but the 
[installation guide](https://wiki.archlinux.org/title/Installation_guide#Connect_to_the_internet) uses `iwctl`.

### System clock

```
root@archiso ~ # timedatectl set-ntp true
```

### Partitions

> [!Note]
> See [1.9 Partition the disks](https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks)

```
root@archiso ~ # fdisk /dev/sda
```

```sh
 # this will clear everything out once the w command is hit, so if you want to dual boot, research another way.
 command (m for help): o

 command (m for help): n
 Partition type
    p   primary (0 primary, 0 extended, 4 free)
    e   extended (container for logical partitions)
 Select (default p): p

 Partition number (1-4, default 1): 1 # can just hit <enter> unless you do not plan on using 1 here

 First sector (2048-976773167, default 2048): <Enter>

 # Used to use +32G, but on last install, kept running low and I needed to clear
 # cache more and more; 64 is overkill probably, but I rarely reach 50% on /home
 # Arch Partitioning docs say "15-20 GiB should be sufficient for most users with
 # modern hard disks."
 Last sector: +64G

 Created a new partition 1 of type 'Linux' and of size 64 GiB.
 Partition #1 contains a ext4 signature. # Says this when I'm reinstalling on the same HD.

 Do you want to remove the signature? [Y]es/[N]o: Y # only shows up when I'm reinstalling

 The signature will be removed by a write command. # Again, shows up on reinstalls.

 # the command `a` in `fdisk` toggles the bootable flag
 command (m for help): a
 Selected partition 1
 The bootable flag on partition 1 is enabled now.

 command (m for help): n
 Partition type
    p   primary (0 primary, 0 extended, 4 free)
    e   extended (container for logical partitions)
 Select (default p): p

 Partition number (2-4, default 2): 2 # can also just hit <enter>

 First sector: <Enter>

 Last sector: +4G

 Created a new partition 2 of type 'Linux' and of size 4 GiB.
 Partition #2 contains a swap signature. # Says this when I'm reinstalling on the same HD.

 Do you want to remove the signature? [Y]es/[N]o: Y # only shows up when I'm reinstalling

 The signature will be removed by a write command. # Again, shows up on reinstalls.

 command (m for help): type

 Partition number(1,2, default 2): 2

 # swap partition value
 Hex value: 82

 Changed type of partition 'Linux' to 'Linux swap / Solaris'.

 command (m for help): n

 Partition type: p

 Partition number: 3

 First sector: <Enter>

 # take up the rest of the hard drive
 Last sector: <Enter>

 Created a new partition 3 of type 'Linux' and of size 3999.8 GiB.
 Partition #3 contains a ext4 signature.

 Do you want to remove the signature? [Y]es/[N]o: Y # only shows up when I'm reinstalling

 The signature will be removed by a write command. # Again, shows up on reinstalls.

 command (m for help): w

 The partition table has been altered.
 Calling ioctl() to re-read partition table.
 Syncing disks.
```

### Formatting the 3 partitions

Arch Linux installation: [1.10 Format the partitions](https://wiki.archlinux.org/title/Installation_guide#Format_the_partitions)

```
 root@archiso ~ # mkfs.ext4 /dev/sda1

 root@archiso ~ # mkfs.ext4 /dev/sda3

 root@archiso ~ # mkswap /dev/sda2

 root@archiso ~ # swapon /dev/sda2
 ```

### Mounting the file system

``` 
 root@archiso ~ # mount /dev/sda1 /mnt

 root@archiso ~ # mkdir /mnt/home

 root@archiso ~ # mount /dev/sda3 /mnt/home
 ```

 The following verifies that `/dev/sda1` and `/dev/sda3` are mounted.

 ```
 root@archiso ~ # mount
 ```

`mount` outputs a lot, the last two lines for each of my installs always have been:

```sh
 # after running `mount` outputs
 ...
 /dev/sda1 on /mnt type ext4 (rw,relatime)
 /dev/sda3 on /mnt/home type ext4 (rw,relatime)
```

## Installation

### Mirrors

Open the file `mirrorlist` and move mirrors closest to your physical location to the top of the list.<br />
Then save and close the file with `:wq`:

```
 root@archiso ~ # vim /etc/pacman.d/mirrorlist
```

Inside of the file `/etc/pacman.conf`, the sections `[community]`, `[community-testing]`, `[testing]`, 
`[testing-debug]`, `[staging]`, `[staging-debug]` need to be commented out.
See [Cleaning up old repositories](https://archlinux.org/news/cleaning-up-old-repositories/). <br />
Before reading the above update, attempting to use `pacstrap` resulted in errors.<br />
For this install, I only needed to comment out `[community]`, because the rest were already commented out or 
they were already removed; so, you may not need to do the following:

```
 root@archiso ~ # vim /etc/pacman.conf
 ```

 ```sh
 # in /etc/pacman.conf

 ...
 #  #[community]
 #  #Include = /etc/pacman.d/mirrorlist
 ...
 ```

### Install packages

> [!Note]
> I used to connect to the internet with `wifi-menu` from `netctl`, but since the documentation now says to use `iwd`, that is what I install instead of `netctl`.

> [!Tip]
> For internet connections with ethernet or some other way than wifi, look at [1.7 Connect to the internet](https://wiki.archlinux.org/title/Installation_guide#Connect_to_the_internet) from the installation guide.

> [!Important]
> If errors occur, run: `pacman -Sy archlinux-keyring`

```
 root@archiso ~ # pacstrap /mnt base base-devel vim linux-lts linux-firmware dhcpcd grub linux-lts-headers wpa_supplicant dialog iwd
```

> [!Note]
> `linux-headers` can be intsalled if you need to get `evdi` and `displaylink` from Arch User Repository for dual monitor setup.

```
 root@archiso ~ # genfstab -U -p /mnt >> /mnt/etc/fstab

 root@archiso ~ # cat /mnt/etc/fstab # shows partititions

 root@archiso ~ # arch-chroot /mnt

 [root@archiso /]# ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

 [root@archiso /]# hwclock --systohc

 [root@archiso /]# locale-gen
 Generating localize...
 Generation complete.
```

Open the file `locale.gen` to uncomment `#en_US.UTF-8 UTF-8`. 

```
 [root@archiso /]# vim /etc/locale.gen
```

Once inside file `locale.gen`, type `/\#en_US\.UTF-8\ UTF-8` then press`<enter>`. Then type `x` to delete the 
`#` symbol. 

```
 [root@archiso /]# vim /etc/locale.conf
```

- Enter `insert` mode by typing `i`
- Save and close file by with `:wq`

```sh
 # in /etc/locale.conf

 LANG=en_US.UTF-8
```

### Set root password 

Type in the password twice; usually with linux pw's, password will not show in terminal and cursor will not 
move.

```
 [root@archiso /]# passwd


 [root@archiso /]# grub-install --target=i386-pc /dev/sda # UEFI has other instructions
 Installing for i386-pc platform
 Installation finished. No error reported.

 [root@archiso /]# grub-mkconfig -o /boot/grub/grub.cfg
 Generating grub configuration file ...
 Found linux image: /boot/vmlinuz-linux
 Found initrd image: /boot/initramfs-linux.img
 Found fallback initrd image(s) in /boot: initramfs-linux-fallback.img
 done"
   #      Last install output more stuff either here or one line above, install still
   #      worked
   #   if nothing was output after grub-mkconfig, something wasn't input correctly.

 # leave arch-chroot mode
```

> [!Note]
> On past installs, the output had maybe a few lines more.

> [!WARNING]
> If nothing was output after running `grub-mkconfig`, then something wasn't input correctly. Check your work.

```
 [root@archiso /]# exit

 root@archiso ~ # umount -R /mnt

 root@archiso ~ # reboot
```

## Boot into archlinux without GUI setup yet

If all went well, then you'll reboot to Arch Linux<br />

> [!Note]
> For username, type: `root`

Again, to connect to the internet, use `iwd` as opposed to `netctl`.

Also, I can't remember what the command line prompt looked like, so I'll just use `[root@archlinux /]`.

### Sign in

```
 [root@archlinux /]# username: root
 password: <type in your password> 
```

### Setup internet just like above with `iwd`

```
[root@archlinux /]# systemctl enable --now systemd-networkd systemd-resolved iwd
[root@archlinux /]# networkctl status -a
```

The following uses `vim` to create and open a new file:

```
[root@archlinux /]# vim /etc/systemd/network/20-wireless.network
```

Inside `20-wireless.network`:

```sh
# In /etc/systemd/network/20-wireless.network

[Match]
Name=wlan0

[Network]
DHCP=yes
```

To exit `insert` mode, type `ctrl-c` (press and hold `ctrl` and then press `c`, or press `esc`).<br />
To save and close file, type `:` followed by `w` then `q` then `<enter>`.

```
[root@archlinux /]# iwctl
[iwd]# station wlan0 connect WifiNetworkName 
[iwd]# exit
```

<hr />

<details>

<summary><strong>Obsolete Internet Access Method</strong></summary>

I'm keeping this material in case I go back to `netctl` one day.<br />

```sh
 # select router, I used default name, type in router password
 # take note of the name, if I think it is here that states the interface
 # (wlp3s0 for me)
 wifi-menu
```

~~In order to auto-login with wifi-menu, either now or after having finished all of these~~
~~instructions, type:~~

```sh
systemctl enable netctl-auto@wlp3s0.service
```

~~The above command has `wlp3s0` as the `interface`~~<br/>
~~substitute your `interface` for `wlp3s0` if it is different.

~~the `enable` will occur everytime the system boots; to start in the current session, you can use~~
~~`start` instead of `enable`~~

~~\*\*\* If you have ethernet and installed networkmanager && dhcpcd (not sure if comes standard~~
~~already) you can use:~~

```sh
systemctl start NetworkManager
```

<strong>End Obsolete Internet Access Method</strong>

</details>

<hr />

## Setting up GUI stuff starts here

Last install had a lot of defaults to enter. I just used the defaults.

> [!Note]
> If you get errors, run: `pacman -Sy archlinux-keyring`

```
 [root@archlinux ~]# pacman -S xorg-server xorg
```

<hr />

<details>

<summary><strong>Did not run these</strong></summary>

```sh
# Did NOT need this on last install
lspci | grep -e VGA -e 3D # shows your video card

# Dit NOT need this on last install
# I think this shows possible list to use (it's in the Arch Linux doc's if I'm wrong).
pacman -Ss xf86-video
```

```diff
- I did NOT run below on last install (pacman -S nvidia). I'm keeping it here as reference to my initial install
```

I have an old nvidia card, NVIDIA Corporation GF119 [GeForce GT 610]

-- I had installed just `nvidia` instead of `nvidia-390xx` on a prior install attempt and nothing showed on monitor; so, be sure to check the docs for what you need for your card.

```sh
# NO NEED TO RUN, ONLY LEFT HERE FOR MY REFERENCE TO INITIAL INSTALL
# CHECK DOC'S IF UNCERTAIN
pacman -S nvidia # nvidia-390xx is only AUR now.
```

```diff
- I did NOT run above on last install (pacman -S nvidia). BE SURE TO REFERENCE THE DOC'S
```

</details>

<hr />

Create `user` and add `user` to `wheel` group:

```
[root@archlinux /]# useradd -m -G users,wheel justin
```

Setup user's password:

```
[root@archlinux /]# passwd justin
```

## The following is for selecting a Desktop Environment

I went with plasma kde, but the doc's have all the info for gnome, xfce, etc.

```
[root@archlinux /]# pacman -S sddm

[root@archlinux /]# systemctl enable sddm.service

[root@archlinux /]# pacman -S plasma konsole dolphin
```

> [!Note]
> If you want google chrome, it's in AUR.<br />
> Also, again, if get errors, run: pacman -Sy archlinux-keyring` and then rerun above install command.

> [!Note]
> You can install `kde-applications` and remove `konsole dolphin` (since those two are included with 
> `kde-applications`) to install a lot of helpful packages for kde, just google 'kde applications'
> and either check the kde website or arch to see all of the packages included.
> > For instance, I tried to download a pdf on chrome, it wouldn't work until I downloaded `okular`, which is included in kde-applications.
> So, the command would be: `pacman -S plasma kde-applications`

## The following is for auto-login

If you don't use this, then on reboot it just asks you to enter in the user's pw before going to
desktop; otherwise, just goes straight to your desktop.

```
[root@archlinux /]# mkdir /etc/sddm.conf.d/

[root@archlinux /]# vim /etc/sddm.conf.d/autologin.conf
```

After opening `autologin.conf` file from above command, press `i` then type: <br />

```sh
# In /etc/sddm.conf.d/autologin.conf

[Autologin]
User=justin
Session=plasma.desktop
```

- then press `cntl-c` or `esc` then type `:wq` (be sure to type `:` before `wq`) <br />
> [!Note]
> Session=plasma.desktop also is used for a `plasma-desktop` instead of just `plasma` install, I've used both

```
[root@archlinux /]# reboot
```

## User Privileges

In a console, type:

```
∫justin ~ sudo EDITOR=vim visudo
```

Go to near the bottom of file and uncomment

```
 %wheel ALL=(ALL) ALL
```

OR, to give wheel group members root privileges, uncomment

```
%wheel ALL=(ALL) ALL NOPASSWD: ALL 
```
> [!Note]
> With `NOPASSWD: ALL`, you will not have to type in password when using commands like `sudo pacman -S nodejs`

The doc's go on to help set up iptables, which is a really easy step-by-step explanation with a good (short) explanation of what each line does.

Installing packages is really easy. The AUR has a lot, and the doc's describe really easy ways of downloading those.
Also, some videos show to update with `pacman -Sy`, but the [doc's](https://wiki.archlinux.org/title/Pacman?redirect=no#Usage) (in the `Warning` at bottom of `Usage` section) clearly state to NOT use that and instead use `pacman -Syu` (At least at the time of me typing this up).
If you forgot to install a console, you can either tty console (see below `booting from usb`) or use boot disk and mount everything and install.

> [!Note]
> For booting from usb

```
 ∫justin ~ mount /dev/sda1 /mnt
 ∫justin ~ mount /dev/sda3 /mnt/home
 
 ∫justin ~ pacstrap /mnt konsole
```

> [!Note]
> For tty, type `Ctrl+Alt+F3` or whichever F# key (I'm not sure which are all console). <br />
> To get back to GUI, I read `Ctrl+Alt+F2` will work, but it didn't for me.
> I also read somewhere a long time ago to use `Ctrl+Alt+F7`, but I could be mistaken. Just look it up to be sure, otherwise just type `reboot` in whatever console envrionment that you are in and you will reboot to GUI.

### For my dual monitor setup

I'm using a startech.com HDMI adapter and I installed `evdi` and `displaylink` from the AUR. Without this, this 
adapter was not working of the other monitor; however, I did not try using other "old" cables. I'll have 
to remember to use other cables first, so these steps <i>might</i> be able to be skipped.

```
 ∫justin ~ git clone https://aur.archlinux.org/evdi.git
 ∫justin ~ cd evdi
 ∫justin ~ makepkg -sic
  
 ∫justin ~ cd ..
 ∫justin ~ git clone https://aur.archlinux.org/displaylink.git
 ∫justin ~ cd displaylink
 ∫justin ~ makepkg -sic
```

See [DisplayLink](https://wiki.archlinux.org/title/DisplayLink) documentation. 
