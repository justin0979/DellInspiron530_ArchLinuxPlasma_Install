# See installed pkgs from pacman and npm

 <details>
   <summary>
   <strong>
      npm
   </strong>

   </summary>

### check globally installed

```sh
npm list -g --depth 0
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
     installed packages are in <code>/var/lib/pacman/local</code>
   </li>
   <li>

To [Remove unused packages (orphans)](<https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)>) run:

```sh
sudo pacman -Qtdq | sudo pacman -Rns -
```

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
