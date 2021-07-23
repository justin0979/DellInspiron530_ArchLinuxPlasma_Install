# See installed pkgs from pacman and npm

## pacman

installed packages are in `/var/lib/pacman/local`

## npm

### check globally installed

```sh
npm list -g --depth 0
```

## minicom

To run:

```sh
sudo minicom -D /dev/ttyACM0
```

To stop, hit `CTRL-A` and then type `q`.

## arduino uno problem connecting

check which port arduino uno is connected to and change
permissions with:

```sh
sudo chmod 666 /dev/ttyACM0
```

(`ttyACM0` is just an example port)

## pacman tips

[Removing unused packages (orphans)](<https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)>)

```sh
sudo pacman -Qtdq | sudo pacman -Rns -
```
