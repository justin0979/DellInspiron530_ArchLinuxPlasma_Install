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

`# Last sector: +32G`

`# command (m for help): a` <---- make partition 1 bootable

`# command (m for help): n`

`# Partition type: p`

`# partition number: 2`

`# First sector: <Enter>`

`# Last sector: +2G (used +12G on latest install just to do it)`

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

`# pacstrap /mnt base base-devel vim linux-lts linux-firmware dhcpcd grub linux-lts-headers linux-headers wpa_supplicant dialog netctl` <-- netctl let me use wifi-menu on reboot, when I left this off, I couldn't use wifi-menu. `networkmanager` can also be installed, but docs show dhcpcd is dependent of netctl (hope I termed that correctly).

`# genfstab -U -p /mnt >> /mnt/etc/fstab`

`# cat /mnt/etc/fstab` <--- shows partititions

`# arch-chroot /mnt`

`# ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime`

`# hwclock --systohc`

`# locale-gen`

`# vim /etc/locale.gen`

-- type: `176 gg`, the press: Enter, then press: Delete, then type `:wq`
-- the above uses Vim to uncomment en_US.UTF-8 UTF-8
-- without doing this, you will see something like "cannot set LC_MESSAGES...no such file or directory", but you'll still be able to "sudo wifi-menu" and select your network and browse internet

`# vim /etc/locale.conf`

-- press "i" then type: LANG=en_US.UTF-8
-- press cntl-c and type: `:wq`

`# passwd`

-- type in your password twice, as with most linux pw's, you won't see what you are typing.

`# grub-install --target=i386-pc /dev/sda` <--- UEFI has other instructions
-- outputs: "Installing for i386-pc platform'
"Installation finished. No error reported."

`# grub-mkconfig -o /boot/grub/grub.cfg`
-- outputs:
"Generating grub configuration file ...
Found linux image: /boot/vmlinuz-linux
Fount initrd image: /boot/initramfs-linux.img
Found fallback initrd image(s) in /boot: initramfs-linux-fallback.img
done"
if nothing was output after grub-mkconfig, something wasn't input correctly.

`# exit` <-- leave arch-chroot mode

`# umount -R /mnt`

`# reboot`

If all went well, then you'll reboot to Arch Linux,
for username, type: root
then your password from earlier

`# wifi-menu`

-- select router, I used default name, type in router password

-- in order to auto-login with wifi-menu, type in `systemctl enable netctl-auto@wlp3s0.service` now or after having set everything up, substitute your `interface` for `wlp3s0` if it is different.

-- the `enable` will occur everytime the system boots, to start in the current session, you can use `start` instead of `enable`

\*\*\* If you have ethernet and installed networkmanager && dhcpcd (not sure if comes standard already) you can use:
`# systemctl start NetworkManager`

`# pacman -S xorg-server xorg` -- GUI stuff starting here

`# lspci | grep -e VGA -e 3D`
-- shows your video card

`# pacman -Ss xf86-video`
-- shows possible list to use (I think, it's in the Arch Linux doc's).

***** I may have left below out on last install

I have an old nvidia card, NVIDIA Corporation GF119 [GeForce GT 610]

-- I had installed just nvidia instead of nvidia-390xx on a prior install attempt and nothing showed on monitor; so, be sure to check the docs for what you need for your card.

`# pacman -S nvidia` -- `nvidia-390xx` is only AUR now.

***** I may have left above out on last install

`# useradd -m -G users,wheel justin`

-- later, type `# EDITOR=vim visudo` and uncomment `%wheel ALL=(ALL) ALL` to give wheel group members root privileges

`# passwd justin`
-- just type in this users pw, same as root pw process

-- the following is for selecting a Desktop Environment, I went with plasma kde, but the doc's have all the info for gnome, xfce, etc.

`# pacman -S sddm` sddm-kcm is dependency of plasma and is installed with plasma

`# systemctl enable sddm.service`

`# pacman -S plasma konsole dolphin` <--- if you want chrome, it's in AUR, which is easy to get with git.

-- Also, in case I forgot to mention this, you can install `kde-applications` and remove `konsole dolphin` (since those two are include with kde-applications) to install a lot of helpful packages for kde, just google 'kde applications' and either check the kde website or arch to see all of the packages included.

-- For instace, I tried to download a pdf on chrome, it wouldn't work until I downloaded `okular`, which is included in kde-applications.

-- So, the command would be `#pacman -S plasma kde-applications`

-- the following is for auto-login, which is nice
-- if you don't use this, then on reboot it just asks you to enter in the user's pw before going to desktop, otherwise, with this, just goes straight to your desktop.

`# mkdir /etc/sddm.conf.d/`

`# vim /etc/sddm.conf.d/autologin.conf`
-- press i then type: <br />
`[Autologin]` <br />
`User=justin` <br />
`Session=plasma.desktop`

-- then press cntl-c then type `:wq` <br />
-- note: Session=plasma.desktop also is used for a plasma-desktop install, I've used both

`# reboot`

The doc's go on to help set up iptables, which is a really easy step by step explanation with a good (short) explanation of what each line does.

Installing packages is really easy. The AUR has a lot, and the doc's describe really easy ways of downloading those.
Also, some videos show to update with `pacman -Sy`, but the doc's clearly state to not use that and instead use `pacman -Syu` (At least at the time of me typing this up).
If you forgot to install a console, you can either tty console or use boot disk and mount everything and install.
