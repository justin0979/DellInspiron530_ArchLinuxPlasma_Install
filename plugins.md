Go and download these first.

### Vim8 package manager

For
With vim 8.2 (what I currently have at this time):<br />

add plugins with `git clone <repo-name>` to:

```sh
mkdir .vim/pack/start/plugins/start
```

For coc, I just followed their docs:

```sh
mkdir .vim/pack/coc/start \
cd .vim/pack/coc/start \
curl --fail -L https:github.com/neoclide/coc.nvim/archive/release.tar.gz|tar xzfv -
```

AFTER the service has started (just wait a few minutes or just open a file in vim and it will tell you it is still installing) run `:CocInfo` to get some info.<br />
Go to [Install coc.nvim: Using vim8's native package manager](https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#using-vim8s-native-package-manager) for more information.

Add to `.vimrc`:

```sh
let g:coc_global_extensions = ['coc-tsserver']
```

<details>
<summary>
  <strong>
  Other packages to possibly get
  </strong>
  </summary>

(Look into coc, b/c things like `coc-prettier` can be used instead)

- [vim-jsonc](https://github.com/kevinoid/vim-jsonc) `git clone git@github.com:kevinoid/vim-jsonc.git`
- ~~ale (not currently using)~~
- auto-pairs
- emmet-vim
- nerdtree
- vim-airline
- ~~vim-css-color (not currently using)~~
- ~~vim-es6 (not currently using)~~
- vim-prettier (run either 'sudo pacman -S prettier' or 'npm i -g prettier' along with installing vim-prettier)
- vim-indent-guide
- airline
</details>

### Colors

Colors can be added to `.vim/colors` and set in `.vimrc`
