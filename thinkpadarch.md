# Verify the boot mode

1. ls /sys/firmware/efi/efivars

# Connect to internet

2. wifi-menu
3. ping archlinux.org

# Update the system clock

4. timedatectl set-ntp true

# Partition disks

5.  fdisk -l
6.  fdisk /dev/sda
7.  Command (m for help): o
8.  Command (m for help): n
9.  Partition type: p
10. Partition number (1-4, default 1): 1
11. First sector(2048-976773167, default: 2048): <enter for default>
12. Last sector: +512M
13. Command (m for help): t
14. Hex code: L
15. Hex code: ef
16. Command (m for help): n
17. Partition type: p
18. Parition number: 2
19. First sector: <enter>
20. Last sector: +2G
21. Command (m for help): type
22. Partition number: 2
23. Hex code: 82 <-- Linux swap
24. Command (m for help): n
25. Partiion type: p
26. Partition number: 3
27. First sector: <enter>
28. Last sector: <enter>
29. Command (m for help): w <-- save

# Format the partition wiki.archlinux.org/index.php/EFI_system_partition#Create_the_partition

30. mkfs.fat -F32 /dev/sda1

# For swap wiki.archlinux.org/index.php/installation_guide

31. mkfs.ext4 /dev/sda3
32. mkswap /dev/sda2
33. swapon /dev/sda2

### POSSIBLE ISSUE AREA

# Mount the file systems

34. mount /dev/sda3 /mnt

# Mirror list

35. pacman -Syy
36. pacman -S reflector
37. cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak (Make mirrorlist backup)
38. reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

# Install essential packages

39. pacstrap /mnt base linux-lts linux-firmware vim linux-lts-headers dhcpcd wpa_supplicant dialog netcl

# Configure the system

## Fstab

40. genfstab -U /mnt >> /mnt/etc/fstab
41. cat /mnt/etc/fstab

## Chroot

42. arch-chroot /mnt

## Time zone

43. ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
44. hwclock --systohc

## Localization

45. vim /etc/locale.gen
46. type `176 gg` press <enter>, type `vd` then `:wq`
47. locale-gen
48. echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Network configuration

49. echo arch > /etc/hostname
    49a. cat /etc/hostname

50. vim /etc/hosts
51. type:
    `127.0.0.1 localhost` <br />
    `::1 localhost` <br />
    `127.0.1.1 arch.localdomain arch` <br />
    '<cntl-c>' then `:wq`

# Root password

52. passwd

# Boot loader

## efibootmgr (wiki.archlinux.org/index.php/GRUB)

### UEFI systems -- Installation

53. pacman -S efibootmgr grub
54. mkdir /boot/efi
55. mount /dev/sda1 /boot/efi
56. grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

## Generate the main confguration file (wiki.archlinux.org/index.php/GRUB#Generate_the_main_configuration_file)

57. grub-mkconfig -o /boot/grub/grub.cfg

# Reboot

58. systemctl enable netctl-auto@<interface>.service (i.e. systemctl enable netctl-auto@wlp3s0.service)
59. exit
60. umount -R /mnt
61. reboot

## sign in:

62. root --> then enter passwd

# Post-installation

## Users

63. useradd -m -G users,wheel justin
64. passwd justin
65. pacman -S sudo
66. EDITOR=vim visudo <br />
    -- find and uncomment `%wheel ALL=(ALL) ALL`

67. pacman -S sddm

### autologin

68. mkdir /etc/sddm.conf.d
69. vim /etc/sddm.conf.d/autologin.conf <br />
    [Autologin]
    User=justin
    Session=plasma.desktop

# Desktop environment setup

70. pacman -S xorg-server xorg
71. systemctl enable sddm.service
72. pacman -S plasma kde-applications bluez bluez-utils pulseaudio-bluetooth ntfs-3g git openssh docker docker-compose <br />
    I hit all defaults
73. systemctl enable bluetooth.service
74. reboot
