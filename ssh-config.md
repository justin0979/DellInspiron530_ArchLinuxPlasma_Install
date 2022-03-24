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
