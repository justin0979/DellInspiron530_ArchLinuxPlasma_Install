Go and download these first.

### Vim8 package manager

With vim 8.2 (what I currently have at this time):<br />

add plugins with `git clone <repo-name>` to:

```sh
mkdir -p .vim/pack/plugins/start \
cd .vim/pack/plugins/start \
git clone <repo-name>

```

`-p` allows for creation of non-existing parent directories.<br />
Otherwise you will have to type `mkdir` for each non-existing
directory as follows:

```sh
mkdir .vim && cd .vim \
mkdir pack && cd pack \
mkdir plugins && cd plugins \
mkdir start && cd start
```

For coc with vim 8.2,:

```sh
cd .vim/pack/plugins/start \
git clone --depth 1 git@github.com:neoclide/coc.nvim.git \
cd coc.nvim \
npm i
```

AFTER the service has started (just wait a few minutes or just
open a file in vim and it will tell you it is still
installing) run `:CocInfo` to get some info.<br />
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

(Look into coc, b/c things like `coc-prettier` can be used instead) <br />
The `git clone` here uses for `ssh` setup.

- [vim-jsonc](https://github.com/kevinoid/vim-jsonc)
  - `git clone git@github.com:kevinoid/vim-jsonc.git`
  - allows comments in .json files
- ~~ale (not currently using)~~
- [auto-pairs](https://github.com/jiangmiao/auto-pairs)
  - `git clone git@github.com:jiangmiao/auto-pairs.git`
- [emmet-vim](https://github.com/mattn/emmet-vim)
  - `git clone git@github.com:mattn/emmet-vim.git`
- [nerdtree](https://github.com/preservim/nerdtree)
  - `git clone git@github.com:preservim/nerdtree.git`
- [vim-airline](https://github.com/vim-airline/vim-airline)
  - `git clone git@github.com:vim-airline/vim-airline.git`
- ~~vim-css-color (not currently using)~~
- ~~vim-es6 (not currently using)~~
- [vim-prettier](https://github.com/prettier/vim-prettier)
  - `git clone git@github.com:prettier/vim-prettier.git`
  - run either `sudo pacman -S prettier` or
    `npm i -g prettier` along with installing vim-prettier
- [vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides)
  - `git clone git@github.com:nathanaelkane/vim-indent-guides.git`
- [vim-rest-console](https://github.com/diepm/vim-rest-console)
  - `git clone git@github.com:diepm/vim-rest-console.git`
  - Similar to Postman
  </details>

### Colors

Colors can be added to `.vim/colors` and set in `.vimrc`
