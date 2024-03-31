<details>
   <summary><strong>AutoLogin</strong><hr/></summary>
  
Autologin after screen sleep/off: <br />
1.) Go to System Settings <br />
2.) type `lock` in search <br />
3.) Go to Screen Locking <br />
4.) uncheck Lock screen: \_\_ Automatically After: 5 minutes <br />

</details>
<details>
    <summary><strong>Mount USB</strong></summary>

-   Insert USB
-   Open terminal
-   type `sudo fdisk -l`
-   Check where USB is located, example output `/dev/sdb1`
-   If not already done, create usb dir: `sudo mkdir /mnt/usb`
-   Mount: `sudo mount /dev/sdb1 /mnt/usb`
-   `cd /mnt/usb`

</details>

<details>
  <summary>
    <strong>Docker</strong>
  </summary>

After installing [docker](https://wiki.archlinux.org/title/docker), remember:

```sh
sudo systemctl enable docker.service
```

to not need `sudo docker`, run `sudo gpasswd -a <username> docker`:

```sh
sudo gpasswd -a justin docker
```

</details>
<details>
  <summary>
  <strong>
    Konsole
  </strong>
  </summary>

Go to following `System settings > Shortcuts`.
If `Konsole` is not listed, then click on `+Add Application` and type in Konsole.<br />
Then, Go to `Konsole > Open a New Window > Add custom shortcut > type in your custom shortcut`

</details>

 <details>
   <summary>
   <strong>
      See installed npm pkgs
   </strong>

   </summary>

check globally installed npm packages:

```sh
npm list -g --depth 0
```

if see:

```sh
/usr/lib
∟-- (empty)
```

then just run:

```sh
npm list -g
```

[Determing which global packages need updating](https://docs.npmjs.com/updating-packages-downloaded-from-the-registry#determining-which-global-packages-need-updating)

```sh
npm outdated -g --depth=0
```

Update single package:

```sh
sudo npm update -g <package_name>
```

Updating all globally-installed packages:

```sh
sudo npm update -g
```

 </details>

<details>
<summary>
<strong>
minicom
</strong>

</summary>

To run:

```sh
sudo minicom -D /dev/ttyACM0
```

To stop, hit `CTRL-A` and then type `q`.

</details>

<details>
  <summary>
  <strong>
    arduino uno problem connecting
  </strong>

  </summary>

check which port arduino uno is connected to and change
permissions with:

```sh
sudo chmod 666 /dev/ttyACM0
```

(`ttyACM0` is just an example port)

</details>

<details>
  <summary>
   <strong>pacman tips</strong>
  </summary>
  <ul>
   <li>
     Reminder to see used and available space: <code>df -h</code>
   </li>
   <li>
     installed packages using pacman are in 
     <code>/var/lib/pacman/local</code>
   </li>
   <li>

To [Remove unused packages (orphans)](<https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)>) run:

```sh
sudo pacman -Qtdq | sudo pacman -Rns -
```

When there are no more orphans, the following will show:

```sh
error: argument '-' specified with empty stdin
```

   </li>
   <li>

For [Cleaning the package cache](https://wiki.archlinux.org/title/Pacman#Cleaning_the_package_cache) run:

I usually run the following to retain only one past version
and free more space:

```sh
paccache -rk1
```

this will retain the most recent 3 versions:

```sh
paccache -r
```

   </li>
  </ul>
</details>

<details>
  <summary><strong>vim-rest-console</strong></summary>

Name file with `.rest`, e.g., `request.rest`.

Comments can be made with `#` or `//`. Below is example:

```sh
// Example for requests.rest

# List all messages
http://localhost:3000
GET /messages

# Create a new message
http://localhost:3000
Content-Type: application/json
POST /messages

# Hitting ctrl-j with cursor on URL will post below object
{
    "title": "Post a new message"
}

# Get a specific message by id
http://localhost:3000
GET /messages/123

# Update a specific message by id
http://localhost:3000
PUT /messages/123

# Hitting ctrl-j with cursor on URL will update below object
{
    "title": "Update them"
}

# Delete a specific message by id
http://localhost:3000
DELETE /messages/123
```

To run, put cursor on line with `http://...` or `GET` or `POST`,
etc and hit `<cntl>j`, the default trigger key.

Look at terminal with running server to see output (if any)

For more info, like configurations, see [vim-rest-console docs](https://github.com/diepm/vim-rest-console/blob/master/doc/vim-rest-console.txt).

</details>

<details>
  <summary><strong>Visual Studio Code</strong></summary>

To edit `settings.json`:

```sh
cd ~/.config/Code/User
```

</details>

<details>
  <summary><strong>QMK</strong></summary>

Refer to [QMK Setup](https://docs.qmk.fm/#/newbs_getting_started) page.

Do the following from home directory. I kept getting errors/warnings about
no `bin/qmk` when I tried cloning my qmk github repo. With `qmk setup` run
from home directory, it asks to clone `qmk_firmware` repo to home
directory (which I eventually did and the following worked.
The docs do show how to clone it to another location, didn't look into it
though).

Follow `Linux/WSL` > `Arch / Manjaro` for setup and testing setup:

```sh
sudo pacman --needed --noconfirm -S git python-pip libffi
sudo pacman -S qmk
qmk setup
qmk compile -kb crkbd -km default
```

Configure build environment to be able to just run `qmk compile` and
`qmk flash` without adding `-kb` and `-km`:

```sh
qmk config user.keyboard=crkbd
qmk config user.keymap=justin0979
qmk compile
```

</details>

<details>
  <summary><strong>NTFS</strong></summary>

If connect usb with

```sh
sudo mount /dev/sda1 /mnt/usbstick
```

or

```sh
sudo mount -t ntfs3 /dev/sda1 /mnt/usbstick
```

or just plug in and get something like:

```sh
mount: /mnt: unknown filesystem type 'ntfs'
```

Install `ntfs-3g`:

```sh
sudo pacman -S ntfs-3g
```

My current kernel is `5.10.87-1-lts`, and according to
[NTFS](https://wiki.archlinux.org/title/NTFS)
you need to have kernal >= `5.15`

</details>

<details>
  <summary><strong>GitHub Token and Github CLI</strong></summary>

When attempting to access a repo and get a message saying that a password has expired and to use a token,
go to GitHub docs [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
and follow the instructions.

Basically, go to `Settings > <> Developer settings > Personal access tokens`<br />
From there, either click on an expired token to regenerate it, or generate a new one.

To not have to enter credentials for each commit, follow [Github CLI](https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git)

To install `gh` on arch linux:

```sh
sudo pacman -S github-cli
```

Then run `gh auth login`<br />

There will be a series of questions that follows, for example:

```sh
? What account do you want to log into? Github.com
? What is your preferred protocol for Git operation? SSH
? Upload your SSH public key to your Github accound? /path/to/key
? How wouild you like to authenticate Github CLI? Paste an authentication token
Tip: you can generate a Personal Access Token here https://github.com/settings/tokens
Then minimum required scopes are 'repo', 'read:org', 'admin:public_key'.
? Paste your authentication token: ***********
- gh config set -h github.com git_protocol ssh
✓ Configured git protocol
HTTP 422: Validation Failed (https://api.github.com/user/keys)
key is already in use
```

If credentials are still required, check that the repo was cloned from SSH.

</details>

<details>
  <summary><strong>Unsquash GIMP toolbar menu</strong></summary>

Go to `Edit --> Preferences --> Interface ->> Toolbox`, then uncheck `Use tool groups`
, then click `OK`

</details>

<details>
<summary><strong>Setup Wacom Cintiq 16 with Startech DisplayLink HDMI to USB</strong></summary>

Referenced [DisplayLink](https://wiki.archlinux.org/title/DisplayLink), specifically section 1.2.

-   [evdi](https://aur.archlinux.org/packages/evdi)
-   [displaylink](https://aur.archlinux.org/packages/displaylink)

Then enabling `displaylink.service`:

```sh
sudo systemctl enable displaylink.service
```

Next, make `20-evda.conf`:

```sh
sudo vim /etc/X11/xorg.conf.d/20-evda.conf
```

Inside `20-evdi.conf`:

```sh
Section "OutputClass"
  Identifier "DisplayLink"
  MatchDriver "evdi"
  Driver "modesetting"
  Option "AccelMethod" "none"
EndSection
```

and then I went ahead and rebooted and everything worked after setting it up monitors in
`System settings`.

**_ I did not need to do the following on last install with linux-lts _**

After reboot, run:

```sh
xrandr --listproviders
```

output:

```sh
Providers: number : 2
Provider 0: id: 0x49 cap: 0xb, Source Output, ...
```

Then run:

```sh
xrandr --setprovideroutputsource 1 0
```

</details>

<details>
  <summary><strong>Limit pen boundary to Wacom Cintiq 16</strong></summary>

First, put Wacom pen nib and eraser close to the Wacom tablet so inputs will register.<br />
Then, get inputs' ids:

```sh
xinput
```

Output will be something like:

```sh
Wacom Cintiq 16 Pen Pen (0x1781901d)     id=12
Wacom Cintiq 16 Pen Eraser (0x1781901d)  id=13
```

Each id might change on each boot.

Next, get the monitors:

```sh
xrandr
```

Output will be something like:

```sh
Screen 0: minimum 320 x 200, current 3841 x 2160, maximum 16384 x 16384
DVI-I-1 disconnected (normal left inverted right x axis y axis)
HDMI-1 connected primary 1920x1080+1+1080 (normal inverted ....)
  1920x1080    60.00*+ 59.96  ...
  ...
VGA-1 connected ...
  ...
DVI-I-1-2 connected ...
  ...
```

Finally, set pen and eraser to Wacom device with command format:

```sh
xinput map-to-output [ID] [monitor]
```

e.g.,

```sh
xinput map-to-output 12 DVI-I-1-2
xinput map-to-output 13 DVI-I-1-2
```

</details>
<details>
  <summary><strong>Reminder for ethernet access on Dell Inspiron laptop</strong><hr /></summary>
  
Get interface with `ip addr`<br />
Then run `sudo ip link set <intertace> up` e.g. `sudo ip link set enp9s0 up`<br />
Then ping a site.

 </details>
<details>
  <summary><strong>gimp screenshot</strong><hr/></summary>

Instead of just running `gimp` from command line, run<br />`dbus-launch gimp`<br />
then go to File >> Create >> Screenshot

  </details>
<details>
  <summary><strong>minikube</strong><hr/></summary>

```sh
minikube start
```

```sh
minikube status
```

if get `machine does not exist` or `Error: No such container: minikube` then run:

```sh
minikube delete
```

and then

```sh
minikube start
```

again.

  </details>
