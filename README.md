# Goals

* Solarize all the things
* Vi keybinds
* Minimalistic
* Performant

# Programs Supported

* [zsh](https://www.zsh.org)
	* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
	* [direnv](http://direnv.net/)
	* [autojump](http://wiki.github.com/joelthelion/autojump)
* [termite](https://github.com/thestinger/termite/)
* [vim](http://www.vim.org/)
* [rofi](https://davedavenport.github.io/rofi)
* [vifm](http://vifm.info/)
* [dunst](http://www.knopwob.org/dunst/)
* [git](http://git-scm.com/)
* [tmux](http://tmux.github.io/)
* [multitail](http://www.vanheusden.com/multitail/)

# Usage

This repo is designed for [nix-home](https://github.com/sheenobu/nix-home) but can be used without it.

Link `default.nix` to your home directory like so:

```
 $ ln -s default.nix ~/default.nix
```

Then rebuild with nix-home when this repo is updated

```
 $ nix-home
```

# Notes

This sets up vim but does not actually install the plugins. You can do so by running the following command:

```
 $ vim +PlugInstall +qall
```
