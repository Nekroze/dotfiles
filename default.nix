with import <nixpkgs> {};
with import <nixhome> { inherit stdenv; inherit pkgs; };
with lib;
let
  ## Customizable
  preferedFont = "Source Code Pro";
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
  solarizedXresources = fetchgit {
    url = "https://github.com/solarized/xresources.git";
    rev = "025ceddbddf55f2eb4ab40b05889148aab9699fc";
    sha256 = "0lxv37gmh38y9d3l8nbnsm1mskcv10g3i83j0kac0a2qmypv1k9f";
  };
  vifmColors = fetchgit {
    url = "https://github.com/vifm/vifm-colors.git";
    rev = "235f9e8728810cfa6c0e07974dbd72ac9158f745";
    sha256 = "0yn9d4ra77ky2hba34d2dccfcmbjk31gp6xkd3g8zv3621kpijfy";
  };
  vimperatorSolarized = fetchgit {
    url = "https://github.com/osakanafish/vimperator-colors-solarized.git";
    rev = "6b67295c6dbafdd41d954a96d2392f9259a8a6c4";
    sha256 = "0ai7iy5grngqmz6376ivdngl3l91kg9ml09qbj41fv7iyrxs25bs";
  };
  zshNotify = fetchgit {
    url = "https://github.com/t413/zsh-background-notify.git";
    rev = "d5f0430cb052f82c433c17707816910da87e201e";
    sha256 = "0p8fk50bxr8kg2v72afg7f2n09n9ap0yn7gz1i78nd54l0wc041n";
  };
  vimDsnips = fetchgit {
    url = "https://github.com/kiith-sa/DSnips.git";
    rev = "dc7239e94a3d52af1f63110344adb8b9f5868a81";
    sha256 = "1y3nwbqh9lrxw4l7jn84s67s7bfyvsng71rz2lckg38j33dr7xyy";
  };
  dotfiles = ./dotfiles;
in mkHome {
  user = "taylorl";
  files = {
    ".config/termite/config".content = ''
      [options]
      font = ${preferedFont} 10
    '' + builtins.readFile "${termiteSolarized}/solarized-dark";
    ".zshrc".content = ''
      export EDITOR=vim
      if [ "$TERM" = 'xterm-termite' ] && ! [ -f "$HOME/.terminfo/r/xterm-termite" ]; then
        export TERM='xterm-256color'
      fi
      [ -f $HOME/.localrc ] && source $HOME/.localrc
      eval $(dircolors ${solarizedDirColors}/dircolors.ansi-dark)

      function notify_formatted {
        ## $1=exit_status, $2=command, $3=elapsed_time
        [ $1 -eq 0 ] && title="Victory!" || title="Asploded!"
        notify-send "$title -- after $3 s" "$2";
      }
      bgnotify_threshold=10
      source ${zshNotify}/bgnotify.plugin.zsh
      export GOPATH="$HOME/go"
      export PATH="$PATH:$GOPATH/bin"
      if command -v dub >/dev/null 2>&1; then
        ls ~/.dub/packages/dcd-* || dub fetch dcd
        ls ~/.dub/packages/dscanner* || dub fetch dscanner
        ls ~/.dub/packages/dfmt* || dub fetch dfmt
      fi
      if command -v opam >/dev/null 2>&1; then
        source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
      fi
    '';
    ".Xresources".content = ''
      rofi.color-enabled: true
      rofi.color-window: #002b37, #002b37, #003642
      rofi.color-normal: #002b37, #819396, #003643, #008ed4, #ffffff
      rofi.color-active: #002b37, #008ed4, #003643, #008ed4, #66c6ff
      rofi.color-urgent: #002b37, #da4281, #003643, #008ed4, #890661
    '' + builtins.readFile "${solarizedXresources}/Xresources.dark";
    ".config/vifm/colors" = vifmColors;
    ".config/dunst/dunstrc" = "${dotfiles}/dunstrc";
    ".config/i3status/config" = "${dotfiles}/i3status";
    ".config/vifm/vifmrc".content = ''
      colorscheme ${vifmTheme}
    '';
    ".vim/autoload/plug.vim" = "${vimPlug}/plug.vim";
    ".vimrc" = "${dotfiles}/vimrc";
    ".gitconfig" = "${dotfiles}/gitconfig";
    ".gitignore" = "${dotfiles}/gitignore";
    ".tmux.conf" = "${dotfiles}/tmux.conf";
    ".multitailrc" = "${dotfiles}/multitailrc";
    ".vimperator/colors" = "${vimperatorSolarized}/colors";
    ".vimperatorrc".content = "colorscheme solarized-dark";
    ".vim/UtiliSnips/d.snippets" = "${vimDsnips}/d.snippets";
  };
}
