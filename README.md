# .dotfiles

There's no place like <b><code>~</code></b> !

## Table of Contents

+ [Introduction](#introduction)
+ [Setup Repository](#setup-repository)
+ [Track Files](#track-files)
+ [Restore Configurations](#restore-configurations)
+ [Additional Commands](#additional-commands)

## Screenshots

![Awesome WM](pictures/screenshot_1.png)
![Awesome WM](pictures/screenshot_2.png)
![Awesome WM](pictures/screenshot_3.png)

## Introduction

This repository contains my personal configuration files (also known as
*dotfiles*). The package lists can be found in `~/.pkglist/`. To install all
official packages, you can use for example `cat .pkglist/pacman | pacman -S -`.

In the following sections I'll explain how this dotfiles repository was set up,
how to use it and how to restore them, for example on a new device.

## Setup Repository

Setup a bare git repository in your home directory. Bare repositories have no
working directory, so setup an alias to avoid typing the long command. Add the
git directory `~/.dotfiles/` to the gitignore as a security measure. Setup
remote and push. Hide untracked files when querying the status.

```bash
git init --bare "$HOME/.dotfiles"

echo 'alias dotfiles="/usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' \
    >> "$HOME/.zshrc"
source "$HOME/.zshrc"

echo '.dotfiles' >> "$HOME/.gitignore"
dotfiles add "$HOME/.gitignore"
dotfiles commit -m 'Git: Add gitignore'

dotfiles remote add origin https://github.com/antob/.dotfiles
dotfiles push --set-upstream origin master
dotfiles config --local status.showUntrackedFiles no
```

## Track Files

Use the default git subcommands to track, update and remove files. You can
obviously also use branches and all other features of git.

```bash
dotfiles status
dotfiles add .zshrc
dotfiles commit -m 'Zsh: Add zshrc'
dotfiles add .vimrc
dotfiles commit -m 'Vim: Add vimrc'
dotfiles push
```

To remove a file from the repository while keeping it locally you can use:

```bash
dotfiles rm --cached ~/.some_file
```

## Restore Configurations

First clone dependent repositories, in this case for example `oh-my-zsh`. Clone
your dotfiles repository as bare repository. Setup temporary alias and then
checkout. If there exist files that collide with your repository (like a default
`.bashrc`), the files will be moved to `~/.dotfiles.bak/`. Then update all
submodules and again hide untracked files when querying the status.

```bash
git clone https://github.com/ohmyzsh/ohmyzsh \
    "$HOME/.oh-my-zsh"

git clone --bare --recursive https://github.com/antob/.dotfiles \
    "$HOME/.dotfiles"

function dotfiles() {
    /usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}
```

Remove all conflicting dotfiles and checkout.

```bash
dotfiles checkout
dotfiles submodule update --recursive --remote
dotfiles config --local status.showUntrackedFiles no
```

Install dependencies.

```bash
cat .pkglist/pacman | sudo pacman -S -
cat .pkglist/aur | yay -S -
```

Set zsh as default shell.

```bash
chsh -s /usr/bin/zsh
```

Reboot!

### Migrate misc settings

List all files not owned by any package
```
# pacreport --unowned-files
```

List changed pacman backup files
```
# pacman -Qii | awk '/^MODIFIED/ {print $2}'
```

List running services
```
$ systemctl
```

Show system status
```
$ systemctl status
```

List of locations to check for config files:

- /etc/udev/rules.d
- /etc/acpi/events
- /etc/modules-load.d
- /etc/modprobe.d
- /etc/efi-keys
- /etc/environment
- /etc/fstab
- /etc/pacman.conf
- /etc/pacman.d/hooks
- /etc/tmpfiles.d
- /etc/X11/xorg.conf
- /etc/X11/xorg.conf.d
- /etc/makepkg.conf


## dotfiles Commands

```bash
function dotfiles() {
    /usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}
```

`compdef` can provide `zsh` autocompletion of the `git` command for your
equivalent `dotfiles` command.

```bash
compdef dotfiles='git'
```

## Additional config

```bash
# /etc/environment
EDITOR=/usr/bin/vim
```

```bash
# /etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	myhostname.localdomain	myhostname
```

### Passwordless sudo

Add to sudoers, using visudo:

```bash
%wheel ALL = (ALL) NOPASSWD: ALL
```

Add user to wheel group

```bash
usermod -aG wheel $USER
```

### Fonts

```bash
# /etc/vconsole.conf
FONT=ter-118b
```

```bash
# ~/.Xresources (font for xterm)
XTerm.vt100.faceName: Hack
```

### Localization

```bash
# /etc/locale.conf (https://wiki.archlinux.org/index.php/Locale)
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_TIME=sv_SE.UTF-8
LC_COLLATE=C
```

Set keyboard layout for X11 (depends on libxkbcommon)
```bash
sudo localectl set-x11-keymap se
```

To enable terminating Xorg with ctrl+alt+backspace use:
```bash
sudo localectl set-x11-keymap se "" "" terminate:ctrl_alt_bksp
```

### Time synchronization

https://gist.github.com/CodingCellist/05556e0cb6cde146fc3f70b578b73da3#time-synchronisation
systemd-timesyncd

### mlocate

```bash
sudo systemctl enable --now updatedb
```

### Set keyboard repeat

For Xorg: `xset r rate [delay] [rate]` (depends on xorg-xset)
```bash
Use `xset r rate 350 40`
```

For virtual console, see https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration#Adjusting_typematic_delay_and_rate

```bash
sudo kbdrate -d 100 -r 40
```

### SSH config

```bash
mkdir ~/.ssh/control
chmod 700 ~/.ssh/control
```

```bash
# ~/.ssh/config
Host *
  ForwardAgent yes
  AddKeysToAgent yes

  # Always use SSH2.
  Protocol 2

  # Use a shared channel for all sessions to the same host,
  # instead of always opening a new one. This leads to much
  # quicker connection times.
  ControlMaster auto
  ControlPath ~/.ssh/control/%r@%h:%p
  ControlPersist 1800

  # also this stuff
  Compression yes
  TCPKeepAlive yes
  ServerAliveInterval 20
  ServerAliveCountMax 10
```


### VMWare

To mute VMWare system beep, add 'mks.noBeep = "TRUE"' to .vmx config file.

Set preferred montor resolution
```bash
# /etc/X11/xorg.conf.d/10-monitor.conf
Section "Monitor"
  Identifier "Virtual1"
  Option "PreferredMode" "1680x1050"
EndSection
```

Mount shared folder

```bash
vmhgfs-fuse .host:/Temp /mnt/share -o subtype=vmhgfs-fuse,allow_other
```
