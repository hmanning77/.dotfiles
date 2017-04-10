.dotfiles
=========

Personal configuration files for various utilities I use.

Usage
-----

### Quick guide
* `user@host:~$ apt install stow || pacman -S stow`
* `user@host:~$ git clone https://github.com/hmanning77/.dotfiles.git`
* `user@host:~$ cd .dotfiles`
* `user@host:~/.dotfiles$ stow <package_name>`

### Details
This dotfile system uses GNU stow to manage packages simply. Each package is simply a subdirectory which contains a file structure to be copied into your home directory. Install GNU stow from your package manager. Clone this repository to your home folder (easiest) or a convenient location. Then change to the repository root and use stow to link the files to your home directory. If you have the repository installed as `~/.dotfiles`, the command is just `stow <package_name>`. If you have it installed elsewhere, you will have to specify your home directory as the destination with `stow -t ~ <package_name>`.

Since each package is just a mirror of the files in your home directory, creating and editing dotfile packages is easy.

Packages
--------

- *fonts*: Customised fontcongig options
  - Enable powerline variation for Terminus
- *mpd*: Lightweight, background music player
  - ncmpcpp console client with custom themeing to better suit Solarized
- *tmux*: Terminal multiplexer
  - Use vi keys in scrollback mode
- *vim*: Amazing editor. I use the Vundle plugin manager
  - Tagbar addon
  - Solarized colourscheme
  - Custom keybindings
- *xresources*
  - Several colourschemes available to be used in .Xresources
  - Font fixes for URxvt
- *zsh*: Personalised shell.
  - Includes ~/.local/bin on $PATH
  - Uses base16 colour schemes
  - Syntax highlighting

Dependencies
------------

Most packages use other programs. I keep my downloaded code in `~/Software/Source` at present. If you download dependencies elsewhere, you will need to substitute some paths to fit your preferred setup.

- [base16-shell](https://github.com/chris-kempson/base16-shell) - Scripts to set pretty colour schemes in your shell which use the 256 colour space to store shades, allowing schemes like Solarized to work without basic tools putting out weird colours.
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - zsh plugin which provides fish-like syntax highlighting
