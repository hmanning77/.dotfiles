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
This dotfile system uses GNU `stow` to manage packages simply. Each package is simply a subdirectory which contains a file structure to be copied into your home directory. Install GNU `stow` from your package manager. Clone this repository to your home folder (easiest) or a convenient location. Then change to the repository root and use `stow` to link the files to your home directory. If you have the repository installed as `~/.dotfiles`, the command is just `stow <package_name>`. If you have it installed elsewhere, you will have to specify your home directory as the destination with `stow -t ~ <package_name>`.

Since each package is just a mirror of the files in your home directory, creating and editing dotfile packages is easy.

Packages
--------

- *tmux* - Terminal multiplexer. Uses vi keys and powerline
- *vim* - VIM editor. Personal shortcuts and Vundle packages
- *xresources* - Solarized colourscheme for URXVT
