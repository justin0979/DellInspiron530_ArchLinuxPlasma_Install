Follow [archlinux Steam page](https://wiki.archlinux.org/title/Steam#Proton_Steam-Play).

## Highlights

### Enable `multilib`:

Uncomment in `/etc/pacman.conf`

```sh
[multilib]
Include = /etc/pacman.d/mirrorlist
```

then upgrade with `sudo pacman -Syyu`

### Install steam

I believe I next ran `sudo pacman -S steam` and just used defaults.

### Fonts (or else just symbols will appear in the text)

Add the fonts with:

```sh
sudo pacman -S lib32-fontconfig ttf-liberation
```

I went ahead and re-ran upgrade.

### Proton setup for Windows games to play on linux

Open steam and sign in.

In the menu go to

```sh
1.) Steam
2.) Settings
3.) Steam Play
4.) Advanced
5.) check Enable Steam Play for all other titles
6.) select Proton 6.3-4 (at this time) from dropdown
```
