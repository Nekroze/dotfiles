# Goals

* Solarize all the things
* Vi keybinds
* Minimalistic
* Performant

# Programs Supported

* [zsh](https://www.zsh.org)
	* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
	* [autojump](http://wiki.github.com/joelthelion/autojump)
* [termite](https://github.com/thestinger/termite/)
* [vim](http://www.vim.org/)
* [neovim](http://neovim.io/)
* [rofi](https://davedavenport.github.io/rofi)
* [vifm](http://vifm.info/)
* [dunst](http://www.knopwob.org/dunst/)
* [git](http://git-scm.com/)
* [tmux](http://tmux.github.io/)
* [multitail](http://www.vanheusden.com/multitail/)
* [oni](https://www.onivim.io) (Due to an [issue with oni](https://github.com/onivim/oni/issues/2087) you need to use oni to edit the config and save with `:w!` before config changes are applied))
* [wtf](https://wtfutil.com)

# Usage

For now this repository must be cloned or linked to `~/.config/dotfiles` to funcion:

```bash
 $ git clone https://github.com/Nekroze/dotfiles.git ~/.config/dotfiles
```

This repo is designed for [nix-home](https://github.com/sheenobu/nix-home) but can be used without it.

```bash
 $ nix-env -f nix-home.nix -i nix-home
```

Link `default.nix` to your home directory like so:

```bash
 $ ln -s $PWD/default.nix ~/default.nix
```

Then rebuild with nix-home when this repo is updated:

```bash
 $ nix-home
```

The above will use default values however you may which to utilize laptop specific configs intsead of dekstop ones or specify your username, `apply.sh` can help you:

```bash
 $ ./apply.sh laptop taylorl
```

# Notes

This sets up vim (and neovim) but does not actually install the plugins. You can do so by running the following command (replace vim with nvim if you use neovim):

```bash
 $ vim +PlugInstall +qall
```
