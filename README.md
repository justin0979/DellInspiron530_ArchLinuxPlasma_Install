# Arch Linux Installation onto Dell Inspiron 530

## The Dell has an upgraded 500 GB Samsung 860 SSD and uBit wifi 6 PCI-e card. I upgraded the video card from I think an amd to an nvidia so that my daughter could play Wizard101 about 8-10 years ago (the amd couldn't handle that game).
## It still has the original intel core 2 quad (which is more than good enough) and all the other components are the original.

### I chose Arch Linux b/c it was one of the distros to use a 5.x kernel, which I read is what is required for wifi ax cards.

### After a lot of pain and closely, but not comprehensively, reading the ArchWiki docs, I was able to finally boot to a lighter weight plasma-desktop. I re-did the install 2 more times to ensure I started to understand some of what I was doing. I then went ahead and just installed full plasma, which I'm very glad I did. The Dell handles this DE very well. I have a dual monitor setup, and plasma came with everything, plasma-desktop didn't come with "out-of-the-box" dual monitor work (or at least one of the packages didn't). 


## There could be several typos here. 
Plus the styling might have highlighted or omitted something, making it hard to read.

I followed the docs about 95% and some youtube videos (about 5%) that coincided with the docs (hence some of the commands being in a slightly different order than the docs).

The docs jumped around and it was very easy to miss a link (like the boot loader part) or to just not understand what an entire section was talking about. If it wasn't for the videos, I would have missed some of the commands I needed to use.

I used `dd` to get a usb iso and booted that way.

After booting from usb

`# wifi-menu`
  -- select your router, I used default name given and then typed in router pw

`# timedatectl set-ntp true`

`# fdisk /dev/sda`

`# command (m for help): o`

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

`# pacstrap /mnt base base-devel vim linux linux-firmware dhcpcd grub linux-headers wpa_supplicant wireless_tools os-prober mtools network-manager-applet networkmanager dialog netctl`

`# genfstab -U -p /mnt >> /mnt/etc/fstab`

`# cat /mnt/etc/fstab` <--- shows partititions

`# arch-chroot /mnt`

`# ip link set wlan0 up`

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

`# grub-install --target=i386-pc /dev/sda`

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

  *** If you have ethernet you can use:
     `# systemctl start NetworkManager`

`# pacman xorg-server xorg`

`# lspci | grep -e VGA -e 3D`
  -- shows your video card

`# pacman -Ss xf86-video`
  -- shows possible list to use (I think, it's in the Arch Linux doc's).

I have an old nvidia card, NVIDIA Corporation GF119 [GeForce GT 610]

`# pacman -S nvidia-390xx nvidia-390xx-utils`

`# useradd -m -g users -G wheel justin`

`# passwd justin`
   -- just type in this users pw, same as root pw process

-- the following is for selecting a Desktop Environment, I went with plasma kde, but the doc's have all the info for gnome, xfce, etc.

`# pacman -S sddm sddm-kcm`

`# systemctl enable sddm.service`

`# pacman -S plasma konsole dolphin kde-applications firefox git`

-- the following is for auto-login, which is nice

`# mkdir /etc/sddm.conf.d/`

`# vim /etc/sddm.conf.d/autologin.conf`
  -- press i then type:  
     `[Autologin]`
     `User=justin`
     `Session=plasma.desktop`

  -- then press cntl-c then type `:wq`
  -- note: Session=plasma.desktop also is used for a plasma-desktop install, I've used both

`# reboot`


