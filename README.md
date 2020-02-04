After booting from usb

\# wifi-menu
  -- select your router, I used default name given and then typed in router pw

\# timedatectl set-ntp true

\# fdisk /dev/sda

\# command (m for help): o

\# command (m for help): n

\# Partition type: p

\# partition number: 1

\# First sector: <Enter>

\# Last sector: +30G

\# command (m for help): a <---- make partition 1 bootable

\# command (m for help): n

\# Partition type: p

\# partition number: 2

\# First sector: <Enter>

\# Last sector: +2G

\# command (m for help): type

\# partition number: 2

\# Hex value: 82 <--- swap

\# command (m for help): n

\# Partition type: p

\# partition number: 3

\# First sector: <Enter>

\# Last sector: <Enter> <--- take up the rest of the hard drive

\# command (m for help): w

\# mkfs.ext4 /dev/sda1

\# mkfs.ext4 /dev/sda3

\# mkswap /dev/sda2

\# swapon /dev/sda2

\# mount /dev/sda1 /mnt

\# mkdir /mnt/home

\# mount /dev/sda3 /mnt/home

\# mount <--- just checks to verify that /dev/sda1 and /dev/sda3 are mounted

\# pacstrap /mnt base base-devel vim linux linux-firmware dhcpcd grub linux-headers wpa_supplicant wireless_tools os-prober mtools network-manager-applet networkmanager dialog netctl

\# genfstab -U -p /mnt >> /mnt/etc/fstab

\# cat /mnt/etc/fstab <--- shows partititions

\# arch-chroot /mnt

\# ip link set wlan0 up

\# vim /etc/locale.gen

-- type: 176 gg <Enter> <Delete> :wq
-- the above uses Vim to uncomment en_US.UTF-8 UTF-8

\# locale-gen

\# ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

\# hwclock --systohc

\# vim /etc/locale.conf

-- press "i" then type: LANG=en_US.UTF-8
-- press <cntl>-c and type: :wq

\# passwd

-- type in your password twice, as with most linux pw's, you won't see what you are typing.

\# grub-install --target=i386-pc /dev/sda

\# grub-mkconfig -o /boot/grub/grub.cfg

\# exit <-- leave arch-chroot mode

\# umount -R /mnt/home

\# umount -R /mnt

\# reboot

If all went well, then you'll reboot to Arch Linux,
for username, type: root
then your password from earlier

\# wifi-menu
  -- select router, I used default name, type in router password

  *** If you have ethernet you can use:
     # systemctl start NetworkManager

\# pacman xorg-server xorg

\# lspci | grep -e VGA -e 3D
  -- shows your video card

\# pacman -Ss xf86-video
  -- shows possible list to use (I think, it's in the Arch Linux doc's).

I have an old nvidia card, NVIDIA Corporation GF119 [GeForce GT 610]

\# pacman -S nvidia-390xx nvidia-390xx-utils

\# useradd -m -g users -G wheel justin

\# passwd justin
   -- just type in this users pw, same as root pw process

-- the following is for selecting a Desktop Environment, I went with plasma kde, but the doc's have all the info for gnome, xfce, etc.

\# pacman -S sddm sddm-kcm

\# systemctl enable sddm.service

\# pacman -S plasma konsole dolphin kde-applications firefox git

-- the following is for auto-login, which is nice

\# mkdir /etc/sddm.conf.d/

\# vim /etc/sddm.conf.d/autologin.conf
  -- press i then type:  
     [Autologin]
     User=justin
     Session=plasma.desktop

  -- then press <cntl>-c then type ":wq"
  -- note: Session=plasma.desktop also is used for a plasma-desktop install, I've used both

\# reboot


