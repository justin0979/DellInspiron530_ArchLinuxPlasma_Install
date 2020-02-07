# Arch Linux Installation onto Dell Inspiron 530
(a reference for me later)

## The Dell has an upgraded 500 GB Samsung 860 SSD and uBit wifi 6 PCI-e card with bluetooth. I upgraded the video card from I think an amd to an nvidia so that my daughter could play Wizard101 about 8-10 years ago (the amd couldn't handle that game).
## It still has the original intel core 2 quad (which is more than good enough) and all the other components are the original.

### I chose Arch Linux b/c it was one of the distros to use a 5.1+ (5.5.2, currently) kernel, which Intel states is required for wifi ax cards.

### After a lot of pain and closely, but not comprehensively, reading the ArchWiki docs, I was able to finally boot to a lighter weight plasma-desktop. I re-did the install 2 more times to ensure I started to understand some of what I was doing. I then went ahead and just installed full Plasma, which I'm very glad I did. The Dell handles this desktop environment very well. I have a dual monitor setup, and plasma came with everything. Plasma-desktop didn't come with "out-of-the-box" dual monitor work (or at least one of the packages didn't). 

Now, my Dell has DL speeds of up to 230 Mbps (thanks to my non-provider modem and WiFi 6 router) on a 200 Mbps plan and bluetooth capabilities. 

## There could be several typos here. 

I followed the docs about 95-99% and some youtube videos (about 1%, I watched those first so I could at least have some idea of what I was reading in the docs) that coincided with the docs (hence some of the commands being in a slightly different order than the docs). Oddly, a youtube series on Arch is dated from Spring 2019, but some of their methods are already outdated and editors like vim and nano are not included in `base`. The youtube series even talked about the AUR and used a little bit longer way instead of simply cloning from github and running a couple other simple commands to get repo's, like the doc's show.

The docs link to other pages for more detail and it was very easy to miss a link (like the boot loader part) or to just not understand what an entire section was talking about. If it wasn't for the videos, I would have missed some of the commands I needed to use. But, after spending more time reading the doc's for setting things up like `iptables`, the doc's ARE the only source you need to use for anything Arch related.

UEFI has only a slightly different method than what follows.

I used `dd` to get a usb iso and booted that way.

After booting from usb

`# wifi-menu`
  -- select your router, I used default name given and then typed in my networks pw

`# timedatectl set-ntp true`

`# fdisk /dev/sda`

`# command (m for help): o` <-- this clears everything out, so if you want to dual boot, research another way.

`# command (m for help): n`

`# Partition type: p`

`# partition number: 1`

`# First sector: <Enter>`

`# Last sector: +30G`

`# command (m for help): a` <---- make partition 1 bootable

`# command (m for help): n`

`# Partition type: p`

`# partition number: 2`

`# First sector: <Enter>`

`# Last sector: +2G`

`# command (m for help): type`

`# partition number: 2`

`# Hex value: 82` <--- swap

`# command (m for help): n`

`# Partition type: p`

`# partition number: 3`

`# First sector: <Enter>`

`# Last sector: <Enter>` <--- take up the rest of the hard drive

`# command (m for help): w`

`# mkfs.ext4 /dev/sda1`

`# mkfs.ext4 /dev/sda3`

`# mkswap /dev/sda2`

`# swapon /dev/sda2`

`# mount /dev/sda1 /mnt`

`# mkdir /mnt/home`

`# mount /dev/sda3 /mnt/home`

`# mount` <--- just checks to verify that /dev/sda1 and /dev/sda3 are mounted

`# pacstrap /mnt base base-devel vim linux linux-firmware dhcpcd grub linux-headers wpa_supplicant wireless_tools os-prober mtools network-manager-applet networkmanager dialog netctl` <-- netctl let me use wifi-menu on reboot, when I left this off, I couldn't use wifi-menu.

`# genfstab -U -p /mnt >> /mnt/etc/fstab`

`# cat /mnt/etc/fstab` <--- shows partititions

`# arch-chroot /mnt`

`# ip link set wlan0 up` <--- saw this in the docs, so I don't know if this sets the wlan0 interface up for after initial reboot.

`# vim /etc/locale.gen`

-- type: `176 gg`, the press: Enter, then press: Delete, then type `:wq`
-- the above uses Vim to uncomment en_US.UTF-8 UTF-8

`# locale-gen`

`# ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime`

`# hwclock --systohc`

`# vim /etc/locale.conf`

-- press "i" then type: LANG=en_US.UTF-8
-- press cntl-c and type: `:wq`

`# passwd`

-- type in your password twice, as with most linux pw's, you won't see what you are typing.

`# grub-install --target=i386-pc /dev/sda` <--- UEFI has other instructions

`# grub-mkconfig -o /boot/grub/grub.cfg`

`# exit` <-- leave arch-chroot mode

`# umount -R /mnt/home`

`# umount -R /mnt`

`# reboot`

If all went well, then you'll reboot to Arch Linux,
for username, type: root
then your password from earlier

`# wifi-menu`
  -- select router, I used default name, type in router password

  *** If you have ethernet and installed dhcpch (not sure if comes standard already) you can use:
     `# systemctl start NetworkManager`

`# pacman xorg-server xorg`

`# lspci | grep -e VGA -e 3D`
  -- shows your video card

`# pacman -Ss xf86-video`
  -- shows possible list to use (I think, it's in the Arch Linux doc's).

I have an old nvidia card, NVIDIA Corporation GF119 [GeForce GT 610]
  -- I had installed just nvidia instead of nvidia-390xx on a prior install attempt and nothing showed on monitor; so, be sure to check the docs for what you need for your card.
`# pacman -S nvidia-390xx nvidia-390xx-utils`

`# useradd -m -g users -G wheel justin`

`# passwd justin`
   -- just type in this users pw, same as root pw process

-- the following is for selecting a Desktop Environment, I went with plasma kde, but the doc's have all the info for gnome, xfce, etc.

`# pacman -S sddm sddm-kcm`

`# systemctl enable sddm.service`

`# pacman -S plasma kde-applications firefox git` <--- if you want chrome, it's in AUR, which is easy to get with git.

-- the following is for auto-login, which is nice
  -- if you don't use this, then on reboot it just asks you to enter in the user's pw before going to desktop, otherwise, with this, just goes straight to your desktop.

`# mkdir /etc/sddm.conf.d/`

`# vim /etc/sddm.conf.d/autologin.conf`
  -- press i then type:  
     `[Autologin]`
     `User=justin`
     `Session=plasma.desktop`

  -- then press cntl-c then type `:wq`
  -- note: Session=plasma.desktop also is used for a plasma-desktop install, I've used both

`# reboot`

The doc's go on to help set up iptables, which is a really easy step by step explanation with a good (short) explanation of what each line does.

Installing packages is really easy. The AUR has a lot, and the doc's describe really easy ways of downloading those.
Also, some videos show to update with `pacman -Sy`, but the doc's clearly state to not use that and instead use `pacman -Syu` (At least at the time of me typing this up).
