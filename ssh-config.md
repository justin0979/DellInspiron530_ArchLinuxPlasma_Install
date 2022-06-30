Install openssh `sudo pacman -S openssh`

From [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent) documentation:

- `ssh-keygen -t ed25519 -C "your_email@google.com"`
- `eval $(ssh-agent -s)`
- `ssh-add ~/.ssh/id_ed25519`

Add the SSH key to GitHub with [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

From the documentation for adding SSH:

```sh
cat ~/.ssh/id_ed25519.pub
# Then select and copy the contents of the id_ed25519.pub file
# displayed in the terminal to your clipboard
```

- Go to `Settings` in GitHub account
- Click `SSH and GPG keys` in side menu
- Add a title
- paste key
- click `Add SSH key` button

Testing SSH connection:
```sh
ssh -T git@github.com
```

This will output:

```sh
The authenticity of host 'github.com (140.82.113.3)' can't be established.
ED25519 key fingerprint is SHA...
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Type in `yes`.

After typing `yes`, output will be something like:
```sh
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
Hi justin0979! You've successfully authenticated...
```
