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

# Get a specific message by id
http://localhost:3000
GET /messages/123
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
