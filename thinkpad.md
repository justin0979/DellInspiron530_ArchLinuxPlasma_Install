# Instructions I most recently used to install on ThinkPad 20CD00B1US

```
uroot@archiso ~ # cat /sys/firmware/efi/tw_platform_size
64

```

## Connect Network

```

root@archiso ~ # ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtl 65536 qdisc...
link/loopback 00:00:00:00:00:00
2: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
link/ether f8:16:54:28:63:51 brd ff:ff:ff:ff:ff:ff
root@archiso ~ # iwctl
[iwd]# device list
                     Devices
-------------------------------------------------------------
 Name       Address             Powered    Adapter    Mode
-------------------------------------------------------------
 wlan0      5c:80:b6:99:99:d9   on         phy0       station

[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
                 Available networks
-------------------------------------------------------------
 Network name        Security              Signal
-------------------------------------------------------------
 N05                 psk                   ****
 Somewifiname        open                  *

[iwd]# station wlan0 connect N05
Type the network passphrase for N05 psk.
Passphrase: **********

[iwd]# exit

root@archiso ~ # ping ping.archlinux.org
PING redirect.archinux.org (95.216.195.133) 56(84) bytes of data.
64 bytes from ....

```

```
root@archiso ~ # timedatectl
Local time: Thu 2025-10-16 17:56:49 UTC
Universal time: Thu 2025-10-16 17:56:49 UTC
RTC time: ...
Time zone: UTC (UTC, +0000)
...

root@archiso ~ # timedatectl set-timezone America/Chicago
root@archiso ~ # timedatectl
Local time: Thu 2025-10-16 12:59:37 CDT
Universal time: Thu 2025-10-16 17:59:37 UTC
RTC time Thu 2025-10-16 17:59:37
Time zone: America/Chicago (CDT, -0500)
...

```

## Partitions

```

root@archiso ~ # fdisk -l
root@archiso ~ # fdisk /dev/sda
Welcome to fdisk (util-linux 2.41.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Command (m for help): o
Created a new DOS (MBR) disklabel with identifier 0xc30522ac.

Command (m for help): n
Partition type
p primary (0 primary, 0 extended, 4 free)
e exttended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): <ENTER>
First sector (2043-976773167, default 2048): <ENTER>
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-976773167, default 976773167): +1G
Partition #1 contains a ext4 signature.

Do you want to remove the signature? [Y]es/[N]o: Y
The signature will be removed by a write command.

Command (m for help): t
Selected partition 1
Hex code or alias (type L to list all): ef
Changed type of partition 'Linux' to 'EFI (FAT-12/16/32)'.

Command (m for help): n
Partition type
p primary (0 primary, 0 extended, 4 free)
e exttended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): <ENTER>
First sector (2099200-976773167, default 2099200): <ENTER>
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2099200-976773167, default 976773167): +4G

Created a new partition 2 of type 'Linux' and of size 4 GiB.

Command (m for help): type
Partition number (1,2, default 2): 2
Hex code or alias (type L to list all): 82

Changed type of partition 'Linux' to 'Linux swap/Solaris'.

Command (m for help): n
Partition type
p primary (0 primary, 0 extended, 4 free)
e exttended (container for logical partitions)
Select (default p): p
Partition number (3-4, default 3): <ENTER>
First sector (10487808-976773167, default 10487808): <ENTER>
Last sector, +/-sectors or +/-size{K,M,G,T,P} (10487808-976773167, default 976773167): <ENTER>

Created a new partition 3 of type 'Linux' and of size 460.8 GiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

```

## Format the partitions

```
root@archiso ~ # mkfs.fat -F32 /dev/sda1
mkfs.fat 4.2 (2021-01-31)

root@archiso ~ # mkfs.ext4 /dev/sda3
mke2fs 1.47.3 (8-Jul-2025)
Discarding device blocks: done
Creating filesystem with 120785670 4k blocks and 30203904 inodes
Filesystem UUID: fb01e086-a97f-41cf-96a8-9b13fd85daa5
Superblock backups stored on blocks:
32768, 98304,...

Allocating group tables: done
Writing inode tables: done
Creating jolrnal (262144 blocks): done
Writing superblocks and filesystem accounting information: done

root@archiso ~ # mkswap /dev/sda2
root@archiso ~ # swapon /dev/sda2

root@archiso ~ # mount /dev/sda3 /mnt
root@archiso ~ # mount --mkdir /dev/sda1 /mnt/boot
```

## Installation

```
root@archiso ~ # vim /etc/pacman.d/mirrorlist
root@archiso ~ # pacman -Sy archlinux-keyring
root@archiso ~ # pacstrap /mnt base base-devel vim linux-lts linux-firmware dhcpcd linux-lts-headers wpa_supplicant dialog iwd intel-ucode man-db efibootmgr grub
```

## Configure the system

```
root@archiso ~ # genfstab -U /mnt >> /mnt/etc/fstab
```

### Chroot

```
root@archiso ~ # arch-chroot /mnt

```

### Time

```
[root@archiso /]# ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
[root@archiso /]# hwclock --systohc
```

### Localization

```
[root@archiso /]# vim /etc/locale.gen
Uncomment en_US.UTF-8 UTF-8

[root@archiso /]# locale-gen
Generating locales...
en_US.UTF-8... done
Generation complete.

[root@archiso /]# echo "LANG=en_US.UTF-8" > /etc/locale.conf
[root@archiso /]# vim /etc/hostname
Type in the hostname: I used "archjm" this last time

[root@archiso /]# passwd
New password:
Retype new password:
passwd: password updated successfully
```

### Boot loader

```
[root@archiso /]# mkdir /efi
[root@archiso /]# mount /dev/sda1 /efi
mount: (hint) your fstab has been modified, but systemb still uses the old version; use 'systemctl daemon-reload' to reload

[root@archiso /]# grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
Installing for x86_64-efi platform.
Installation finished. No error reported.
```

#### Generate the main configuration file

```
[root@archiso /]# grub-mkconfig -o /boot/grub/grub.cfg
Generation grub configuration file ...
Found linux image: /boot/vminuz-linux-lts
Found initrd image: /boot/intel-ucode.img /boot/initramfs-linux-lts.img
Found fallback initrd images(s) in /boot: intel-ucode.img initramfs-linux-lts-fallback.img
Warning: os-prober will not be executed to detect other bootable partitions.
Sytems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
done

[root@archiso /]# exit
```

## Reboot

```
root@archiso ~ # umount -R /mnt
root@archiso - # reboot

```

```
archjm login: root
Password:
```

```
[root@archjm ~]# systemctl enable --now systemd-networkd systemd-resolved dhcpcd iwd
[root@archjm ~]# iwctl
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
[iwd]# station wlan0 connect N05
[iwd]# exit
```

> [!Note]
> After enabling `dhcpcd.service`, the command `systemctl start dhcpcd.service` may have to be run if ping is unsuccessful.

```
[root@archjm ~]# ping ping.archlinux.org

[root@archjm ~]# useradd -m -G users,wheel justin
[root@archjm ~]# passwd justin
New password:
Retype password:
passwd: password updated successfully

[root@archjm ~]# pacman -S sddm
resolving dependencies...
:: There are 11 providers available for ttf-font:
:: Repository extra

1) gnu-free-fonts 2)...
   Enter a number (default=1): 1

[root@archjm ~]# systemctl enable sddm.service

```

### Setup autologin

```

[root@archjm ~]# mkdir /etc/sddm.conf.d
[root@archjm ~]# vim /etc/sddm.conf.d/autologin.conf

```

In /etc/sddm.conf.d/autologin.conf:

```sh
[Autologin]
User=justin
Session=plasma.desktop
```

```
[root@archjm ~]# pacman -S plasma konsole dolphin git firefox openssh
[root@archjm ~]# reboot
```
