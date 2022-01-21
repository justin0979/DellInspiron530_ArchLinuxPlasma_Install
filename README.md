# Arch Linux Installation onto Dell Inspiron 530

A reference for me later (on a 2007-2008 desktop). I randomly update some of the text here, so
some specs will be mismatched in places.<br />
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

I used `dd` to get a usb iso and booted that way. Here's the link to [Arch Linux Downloads](https://archlinux.org/download/)

After booting from usb:

```sh
 # select your router, I used default name given and then typed in my networks pw
 wifi-menu

 timedatectl set-ntp true

 fdisk /dev/sda

 # this clears everything out, so if you want to dual boot, research another way.
 command (m for help): o

 command (m for help): n

 Partition type: p

 partition number: 1

 First sector: <Enter>

 # Used to use +32G, but on last install, kept running low and I needed to clear
 # cache more and more; 64 is overkill probably, but I rarely reach 50% on /home
 # Arch Partitioning docs say "15-20 GiB should be sufficient for most users with
 # modern hard disks."
 Last sector: +64G

 # make partition 1 bootable
 command (m for help): a

 command (m for help): n

 Partition type: p

 partition number: 2

 First sector: <Enter>

 # used +12G on one install just to do it, but usually around 2G, doc's say something
 # more than 512 MB
 Last sector: +2G

 command (m for help): type

 partition number: 2

 # swap
 Hex value: 82

 command (m for help): n

 Partition type: p

 partition number: 3

 First sector: <Enter>

 # take up the rest of the hard drive
 Last sector: <Enter>

 command (m for help): w

 mkfs.ext4 /dev/sda1

 mkfs.ext4 /dev/sda3

 mkswap /dev/sda2

 swapon /dev/sda2

 mount /dev/sda1 /mnt

 mkdir /mnt/home

 mount /dev/sda3 /mnt/home

 # just checks to verify that /dev/sda1 and /dev/sda3 are mounted
 mount

 # move mirrors closest to your physical location by either
 # commenting out mirrors at top of list, or cut (dd) and
 # paste (p) to top of list
 # save with :wq
 vim /etc/pacman.d/mirrorlist

 # netctl let me use wifi-menu on reboot, when I left this off, I couldn't use
 # wifi-menu.
 #`networkmanager` can also be installed, but docs show dhcpcd is dependent of netctl.
 pacstrap /mnt base base-devel vim linux-lts linux-firmware dhcpcd grub linux-lts-headers linux-headers wpa_supplicant dialog netctl

 genfstab -U -p /mnt >> /mnt/etc/fstab

 cat /mnt/etc/fstab # shows partititions

 arch-chroot /mnt

 ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

 hwclock --systohc

 locale-gen

 vim /etc/locale.gen
   # type: `177 gg` and press "Enter". This will put cursor on line 177 where
   # "#en_US.UTF-8 UTF-8" is located at this time.
   # then press: `x` to delete "#" symbol, then type `:wq` to save and exit file.
   # without uncommenting above, you will see something like:
   #   "cannot set LC_MESSAGES...no such file or directory"
   #     you'll still be able to "sudo wifi-menu" and select your network and browse
   #     internet

 vim /etc/locale.conf
   # press "i" then type: LANG=en_US.UTF-8
   # press cntl-c and type: `:wq`

 # type in your password twice; as with most linux pw's, you won't see what you are
 # typing.
 passwd


 grub-install --target=i386-pc /dev/sda # UEFI has other instructions
   # outputs: "Installing for i386-pc platform'
   #          "Installation finished. No error reported."

 grub-mkconfig -o /boot/grub/grub.cfg
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
 exit

 umount -R /mnt

 reboot
```

## Boot into archlinux without GUI setup yet

If all went well, then you'll reboot to Arch Linux<br />
For username, type: `root` <br />
then enter your password from earlier and type in the following:

```sh
 # select router, I used default name, type in router password
 # take note of the name, if I think it is here that states the interface
 # (wlp3s0 for me)
 wifi-menu
```

In order to auto-login with wifi-menu, either now or after having finished all of these
instructions, type:

```sh
systemctl enable netctl-auto@wlp3s0.service
```

The above command has `wlp3s0` as the `interface`<br/>
substitute your `interface` for `wlp3s0` if it is different.

the `enable` will occur everytime the system boots; to start in the current session, you can use
`start` instead of `enable`

\*\*\* If you have ethernet and installed networkmanager && dhcpcd (not sure if comes standard
already) you can use:

```sh
systemctl start NetworkManager
```

## Setting up GUI stuff starts here

```sh
# Last install showed a lot of defaults to enter. I may have either just hit `1`
# or all defaults
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

Later in a console, type:

```sh
EDITOR=vim visudo
  # Go to near the bottom of file and
  # uncomment `%wheel ALL=(ALL) ALL`
  #       OR
  # uncomment `%wheel ALL=(ALL) ALL NOPASSWD: ALL` to give wheel group members root privileges
  #   with NOPASSWD: ALL, you will not have to type in pw on commands like `sudo pacman -S nodejs`
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
#   pacman -S keyring
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
