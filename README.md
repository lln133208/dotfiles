# my-dotfiles #

This repo includes my configuration files which can be managed by GNU Stow.

Repo structure

```
-dofiles
|-- git
|----|-- .gitmessage
|-- tmux
|----|-- .tmux.conf
|-- oh-my-zsh
|----|-- .zshrc
|----|-- .oh-my-zsh
|-- posh
|----|-- .mytheme.omp.json
|----|-- Microsoft.PowerShell_profile.ps1
|-- ideavim
|----|-- .ideavimrc
```

## git ##

* .gitmessage

    prompt template for commit message. It will applied when committing.

## tmux ##

`.tmux.conf` is configurations of tmux.

## oh-my-zsh ##

Configuration files for zsh

## posh
> Windows only

Configuration files for posh

`.mytheme.omp.json` is used for posh propmt

`Microsoft.PowerShell_profile.ps1` is shell profile to load posh.

## ideavim
> Windows only

vim keyboard mapping for idea IDE

# Tooltip:

## Create symbol link

* Windows

    ```powershell
    New-Item -ItemType symboliclink -Path path/to/create/symboliclink -Name name/of/symboliclink -Value source/of/Symboliclink
    ```

* Linux

    Xstow is recommended.

