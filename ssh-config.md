Install openssh `sudo pacman -S openssh`

`ssh-keygen -t rsa -b 4096 -C "your@email.com"`

`eval $(ssh-agent -s)`

`ssh-add ~/.ssh/id_rsa`

make config file in `./.ssh/config`

in config <br />
`IdentityFile ~/.ssh/gitHubKey` <br />
`IdentityFile ~/.ssh/id_rsa` <br />

If you entered passphrase during keygen, enter it when using ssh.

`chmod 600 config`
