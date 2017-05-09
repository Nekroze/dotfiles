with import <nixpkgs> {};
with import <nixhome> { inherit stdenv; inherit pkgs; };
with lib;
let
  ## Customizable
  zshTheme = "flazz";
  zshCustom = "$HOME/.config/zsh";
  zshViMode = true;
  zshPlugins = [
    "git"
    "common-aliases"
    "jira"
    "ssh-agent"
    "gitfast"
    "docker"
    "dirhistory"
    "per-directory-history"
    "perms"
    "sudo"
    "systemd"
    "web-search"
    "history-substring-search"
  ];
  zshAutojump = true;
  preferedFont = "Source Code Pro 10";
  vifmTheme = "solarized-dark";
  ## Repositories
  termiteSolarized = fetchgit {
    url = "https://github.com/alpha-omega/termite-colors-solarized.git";
    rev = "e7bccb4fc563f71febce32819babf5d855ef3337";
    sha256 = "1ja49d2062bb3b8wkk3yh9w0wwxai5nq2dpawsxnih9gkfy4rxin";
  };
  vimPlug = fetchgit {
    url = "https://github.com/junegunn/vim-plug.git";
    rev = "b44ea685aa2899316e58cba646095fa7551f8808";
    sha256 = "0j1sb1sadp88kzmzz4d2mn0qz3ja180h1ib951wy2dksl8as6shm";
  };
  solarizedDirColors = fetchgit {
    url = "https://github.com/seebi/dircolors-solarized.git";
    rev = "71dbfd5ea3e39b41977df36a61bedc5f9374d47e";
    sha256 = "0v779ig3kcd64zymjvxk6gigawqbznq3z1ckm604511jqigm1mdi";
  };
  vifmColors = fetchgit {
    url = "https://github.com/vifm/vifm-colors.git";
    rev = "235f9e8728810cfa6c0e07974dbd72ac9158f745";
    sha256 = "0yn9d4ra77ky2hba34d2dccfcmbjk31gp6xkd3g8zv3621kpijfy";
  };
  dotfiles = ./dotfiles;
in mkHome {
  user = "taylorl";
  files = {
    ".config/termite/config".content = ''
      [options]
      font = ${preferedFont}
    '' + builtins.readFile "${termiteSolarized}/solarized-dark";
    ".bashrc".content = ''
      export EDITOR=vim
      [ -f $HOME/.localrc ] && source $HOME/.localrc
      eval $(dircolors ${solarizedDirColors}/dircolors.256dark)
    '' + builtins.readFile "${dotfiles}/bashrc";
    ".zshrc".content = let
      plugins = zshPlugins ++ optionals zshViMode [ "vi-like" "vi-mode" ];
    in ''
      export EDITOR=vim
      [ -f $HOME/.localrc ] && source $HOME/.localrc
      eval $(dircolors ${solarizedDirColors}/dircolors.ansi-dark)

      ${optionalString zshAutojump "source ${autojump}/share/autojump/autojump.zsh"}

      export ZSH=${oh-my-zsh}/share/oh-my-zsh/
      ZSH_CUSTOM="${zshCustom}"
      mkdir -p $ZSH_CUSTOM/themes

      ZSH_THEME="${zshTheme}"
      plugins=(${concatStringsSep " " plugins})

      source $ZSH/oh-my-zsh.sh
    '';
    ".config/vifm/colors" = vifmColors;
    ".config/vifm/vifmrc".content = ''
      colorscheme ${vifmTheme}
    '';
    ".vim/autoload/plug.vim" = "${vimPlug}/plug.vim";
    ".vimrc" = "${dotfiles}/vimrc";
    ".gitconfig" = "${dotfiles}/gitconfig";
    ".gitignore" = "${dotfiles}/gitignore";
    ".tmux.conf" = "${dotfiles}/tmux.conf";
    ".multitailrc" = "${dotfiles}/multitailrc";
  };
}
