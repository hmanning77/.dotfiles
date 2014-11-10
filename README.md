.dotfiles
=========

Personal configuration files for various utilities I use.

Usage
-----

### Quick guide
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
- *powerline*: For awesome statusbars in the terminal.
  - Different colourschemes for different applications to make it easy to parse nested interfaces at a glance (i.e. zsh and vim next to each other inside tmux)
- *sxhkd-elementary*: Custom keybindings since elementary-os doesn't allow you to define your own by default
- *tmux*: Terminal multiplexer
  - Use vi keys in scrollback mode
  - Powerline
- *vim*: Amazing editor. I use the Vundle plugin manager
  - Tagbar addon
  - Solarized colourscheme
  - Powerline
  - Custom keybindings
- *xresources*
  - Solarized colourscheme for URXVT
- *zsh*: Personalised shell.
  - Syntax highlighting
  - Powerline
  - Solarized dircolors

Dependencies
------------

Most packages use other programs. I keep my downloaded code in `~/Software/Source` at present. If you download dependencies elsewhere, you will need to substitute some paths to fit your preferred setup.

- [Powerline](https://github.com/lokaltog/powerline) - Used for customised prompts and statuslines. These dotfiles are configured for a pip install
- [Powerline Fonts](https://github.com/lokaltog/powerline-fonts) - For fancy glyph support in urxvt
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - zsh plugin which provides fish-like syntax highlighting
