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
