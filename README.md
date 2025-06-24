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

I've ommitted the command line prompts' `#` symbol (like `root@archiso ~ #`) since in the code blocks, the 
octothorp is used for comments.

### Boot from usb:

Just plug it in and hit `f12` or whichever key gets you into the bootloader.

### Set up internet connection:

```sh
root@archiso ~ systemctl enable --now systemd-networkd systemd-resolved iwd
root@archiso ~ networkctl status -a
root@archiso ~ vim /etc/systemd/network/20-wireless.network # creates new file `20-wireless.network`
```
-- in `20-wireless.network`, enter `insert` mode by pressing `i`:

```sh
[Match]
Name=wlan0

[Network]
DHCP=yes
```
Save and close the file by typing `:` followed by `wq`.

[Arch linux iwd link](https://wiki.archlinux.org/title/Iwd#iwctl)</br>
Now the interactive prompt can be accessed with `iwctl` and the wifi device (`wlan0` from above) and network 
name can be set (whatever you wifi network's name is):

```sh
root@archiso ~ iwctl
[iwd] station wlan0 connect FakeWifiName-5G
[iwd] exit
```

Also, `wifi-menu` can still be used also, but the 
[installation guide](https://wiki.archlinux.org/title/Installation_guide#Connect_to_the_internet) uses `iwctl`.

### System clock

```sh
root@archiso ~ timedatectl set-ntp true
```

### Partitions

```sh
 fdisk /dev/sda

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
Arch Linux installation: [Format the partitions](https://wiki.archlinux.org/title/Installation_guide#Format_the_partitions)

```sh
 root@archiso ~ mkfs.ext4 /dev/sda1

 root@archiso ~ mkfs.ext4 /dev/sda3

 root@archiso ~ mkswap /dev/sda2

 root@archiso ~ swapon /dev/sda2
 ```
### Mounting the file system

```sh 
 root@archiso ~ mount /dev/sda1 /mnt

 root@archiso ~ mkdir /mnt/home

 root@archiso ~ mount /dev/sda3 /mnt/home

 # verifies that /dev/sda1 and /dev/sda3 are mounted, they'll be the last two lines (at least in all of my past installs they have been).
 root@archiso ~ mount
```

## Installation

### Mirrors

This section is updated since inside of `/etc/pacman.conf`, `[community]`, `[core-testing]`, and some others 
will not be used anymore. So, besure to open `etc/pacman.conf` and comment these sections out like below:

```sh
 # move mirrors closest to your physical location by either
 # commenting out mirrors at top of list, or cut (dd) and
 # paste (p) to top of list
 # save with :wq
 root@archiso ~ vim /etc/pacman.d/mirrorlist

 # open the following file and comment out [community]
 root@archiso ~ vim /etc/pacman.conf
 # comment out:
 #  #[community]
 #  #Include = /etc/pacman.d/mirrorlist
 ```

### Install packages

As mentioned above, I used to use `wifi-menu` from `netctl` to access the internet; but, the intsallation 
guide says to use `iwd`. So, that is what I did here. 

For internet connections with ethernet or some other way than wifi, look at 
[1.7 Connect to the internet](https://wiki.archlinux.org/title/Installation_guide#Connect_to_the_internet) from 
the installation guide.

```sh
 #`networkmanager` can also be installed, but docs show dhcpcd is dependent of netctl.
 # if errors occur, run: pacman -Sy archlinux-keyring
 root@archiso ~ pacstrap /mnt base base-devel vim linux-lts linux-firmware dhcpcd grub linux-lts-headers wpa_supplicant dialog iwd

 root@archiso ~ genfstab -U -p /mnt >> /mnt/etc/fstab

 root@archiso ~ cat /mnt/etc/fstab # shows partititions

 root@archiso ~ arch-chroot /mnt

 [root@archiso /] ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

 [root@archiso /] hwclock --systohc

 [root@archiso /] locale-gen
 Generating localize...
 Generation complete.

 [root@archiso /] vim /etc/locale.gen
   # type: `177 gg` and press "Enter". This will put cursor on line 177 where
   # "#en_US.UTF-8 UTF-8" is located at this time.
   # then press: `x` to delete "#" symbol, then type `:wq` to save and exit file.
   # without uncommenting above, you will see something like:
   #   "cannot set LC_MESSAGES...no such file or directory"
   #     you'll still be able to "sudo wifi-menu" and select your network and browse
   #     internet

 [root@archiso /] vim /etc/locale.conf
   # press "i" then type: LANG=en_US.UTF-8
   # press cntl-c and type: `:wq`

 # type in your password twice; as with most linux pw's, you won't see what you are
 # typing.
 [root@archiso /] passwd


 [root@archiso /] grub-install --target=i386-pc /dev/sda # UEFI has other instructions
   # outputs: "Installing for i386-pc platform'
   #          "Installation finished. No error reported."

 [root@archiso /] grub-mkconfig -o /boot/grub/grub.cfg
   # outputs:
   #   "Generating grub configuration file ...
   #   Found linux image: /boot/vmlinuz-linux
   #   Found initrd image: /boot/initramfs-linux.img
   #   Found fallback initrd image(s) in /boot: initramfs-linux-fallback.img
   #   done"
   #      Last install output more stuff either here or one line above, install still
   #      worked
   #   if nothing was output after grub-mkconfig, something wasn't input correctly.

 # leave arch-chroot mode
 [root@archiso /] exit

 root@archiso ~ umount -R /mnt

 root@archiso ~ reboot
```

## Boot into archlinux without GUI setup yet

If all went well, then you'll reboot to Arch Linux<br />
For username, type: `root` <br />
then enter your password from earlier and type in the following:

Again, to connect to the internet, use `iwd` as opposed to `netctl`.

Also, I can't remember what the command line prompt looked like, so I'll just use `[root@archiso /]`.

### Sign in

```sh
 [root@archiso /] username: root
 password: <type in your password> 
```

### Setup internet just like above with `iwd`

### Obsolete internet access method

~~I'm keeping this material in case I go back to `netctl` one day.
~~```sh
~~ # select router, I used default name, type in router password
~~ # take note of the name, if I think it is here that states the interface
~~ # (wlp3s0 for me)
~~ wifi-menu
~~```

~~
~~In order to auto-login with wifi-menu, either now or after having finished all of these
~~instructions, type:
~~
~~```sh
~~systemctl enable netctl-auto@wlp3s0.service
~~```
~~
~~The above command has `wlp3s0` as the `interface`<br/>
~~substitute your `interface` for `wlp3s0` if it is different.
~~
~~the `enable` will occur everytime the system boots; to start in the current session, you can use
~~`start` instead of `enable`
~~
~~\*\*\* If you have ethernet and installed networkmanager && dhcpcd (not sure if comes standard
~~already) you can use:
~~
~~```sh
~~systemctl start NetworkManager
```
### End Obsolete internet access method

## Setting up GUI stuff starts here

```sh
# Last install showed a lot of defaults to enter. I may have either just hit `1`
# or all defaults
# If get errors, run: pacman -Sy archlinux-keyring
pacman -S xorg-server xorg

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

```sh
# Create user and add user to wheel group
useradd -m -G users,wheel justin
```

Setup user's password:

```sh
passwd justin
```

## The following is for selecting a Desktop Environment

I went with plasma kde, but the doc's have all the info for gnome, xfce, etc.

```sh
pacman -S sddm
  # sddm-kcm is dependency of plasma and is installed with plasma

systemctl enable sddm.service

# if you want chrome, it's in AUR, which is easy to get with git.
# after running below, if get trust errors, even from the documented trusted users list,
# run:
#   pacman -Sy archlinux-keyring
# then run below again
pacman -S plasma konsole dolphin
```

You can install `kde-applications` and remove `konsole dolphin` (since those two are included with
`kde-applications`) to install a lot of helpful packages for kde, just google 'kde applications'
and either check the kde website or arch to see all of the packages included.

-- For instance, I tried to download a pdf on chrome, it wouldn't work until I downloaded `okular`, which is included in kde-applications.

-- So, the command would be: `pacman -S plasma kde-applications`

## The following is for auto-login

If you don't use this, then on reboot it just asks you to enter in the user's pw before going to
desktop; otherwise, just goes straight to your desktop.

```sh
mkdir /etc/sddm.conf.d/

vim /etc/sddm.conf.d/autologin.conf
```

After opening `autologin.conf` file from above command, press `i` then type: <br />

```sh
[Autologin]
User=justin
Session=plasma.desktop
```

-- then press `cntl-c` or `esc` then type `:wq` (be sure to type `:` before `wq`) <br />
-- note: Session=plasma.desktop also is used for a `plasma-desktop` instead of just `plasma` install, I've used both

```sh
reboot
```

## User Privileges

In a console, type:

```sh
sudo EDITOR=vim visudo
  # Go to near the bottom of file and
  # uncomment `%wheel ALL=(ALL) ALL`
  #       OR
  # uncomment `%wheel ALL=(ALL) ALL NOPASSWD: ALL` to give wheel group members root privileges
  #   with NOPASSWD: ALL, you will not have to type in pw on commands like `sudo pacman -S nodejs`
```

The doc's go on to help set up iptables, which is a really easy step-by-step explanation with a good (short) explanation of what each line does.

Installing packages is really easy. The AUR has a lot, and the doc's describe really easy ways of downloading those.
Also, some videos show to update with `pacman -Sy`, but the [doc's](https://wiki.archlinux.org/title/Pacman?redirect=no#Usage) (in the `Warning` at bottom of `Usage` section) clearly state to NOT use that and instead use `pacman -Syu` (At least at the time of me typing this up).
If you forgot to install a console, you can either tty console (see below) or use boot disk and mount everything and install.

-- Note: For booting from usb

```sh
mount /dev/sda1 /mnt
mount /dev/sda3 /mnt/home

pacstrap /mnt konsole
```

-- Note: For tty, type `Ctrl+Alt+F3` or whichever F# key (I'm not sure which are all console). <br />
To get back to GUI, I read `Ctrl+Alt+F2` will work, but it didn't for me.
I also read somewhere a long time ago to use `Ctrl+Alt+F7`, but I could be mistaken. Just look it up to be sure, otherwise just type `reboot` in whatever console envrionment that you are in and you will reboot to GUI.
