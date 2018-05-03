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
    rev = "e6a775e0df3180d3cfea55b351aa7b112c58c139";
    sha256 = "1zigz3p9hbqr0rf07v98rrszl9mgr9xx1ai4pjqnl0z0m8pya62w";
  };
  solarizedDirColors = fetchgit {
    url = "https://github.com/seebi/dircolors-solarized.git";
    rev = "2720cb1ff508bc358f9414f63370f0c6cd767b98";
    sha256 = "1mk7d7l6v4vfgkp3005533yd4gldm07cjqmqs6fxzwjjwj7l5qbf";
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
  vimPluginGo = fetchgit {
    url = "https://github.com/fatih/vim-go.git";
    rev = "7491209072ed4aa746e6fe7894f976ecd251801e";
    sha256 = "1a7fy8n9h383776jixlwxl8y3h8h5mixi0bcv4lv61x0g3xxh8gx";
  };
  gtkSolarized = ((pkgs.callPackage ./dotfiles/numix-solarized.nix) { });
  dotfiles = ./dotfiles;
  mkDesktop = name: exec: ''
    [Desktop Entry]
    Type=Application
    Encoding=UTF-8
    Name=${name}
    Exec=${exec}
    Terminal=false
  '';
  writeFishScript = name: text:
    writeTextFile {
      inherit name;
      executable = true;
      text = ''
        #!${pkgs.fish}/bin/fish
        ${text}
        '';
      checkPhase = ''
        export HOME=$(mktemp -d)
        mkdir -p $HOME
        ${pkgs.fish}/bin/fish -n $out
      '';
    };
  writeFishAlias = name: command: writeFishScript "${name}.fish" ''
      function ${name}
        ${command}
      end
    '';
in mkHome rec {
  user = "taylorl";
  files = {
    ".config/termite/config".content = ''
      [options]
      font = ${preferedFont} 10
    '' + builtins.readFile "${termiteSolarized}/solarized-dark";

    ".zshrc".content = ''
      export EDITOR=vim
      if [ "$TERM" = 'xterm-termite' ] && ! [ -f "$HOME/.terminfo/x/xterm-termite" ]; then
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
        ls ~/.dub/packages/dcd-* >/dev/null 2>&1 || dub fetch dcd
        ls ~/.dub/packages/dscanner* >/dev/null 2>&1 || dub fetch dscanner
        ls ~/.dub/packages/dfmt* >/dev/null 2>&1 || dub fetch dfmt
      fi
      if command -v opam >/dev/null 2>&1; then
        source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
      fi
      function df_upload() {
        rsync --delete -avh ~/.local/share/df_linux/data/save ~/keybase/private/nekroze/df_saves
      }
      function df_download() {
        rsync --delete -avh ~/keybase/private/nekroze/df_saves/save ~/.local/share/df_linux/data
      }
      export PATH="$PATH:$HOME/.bin"
      export WORKON_HOME=$HOME/.pyvenvs
      mkdir -p $WORKON_HOME
      [ "$IN_NIX_SHELL" ] && export PS1="nix-shell@$PS1"
      alias ls="${pkgs.exa}/bin/exa"
      alias ll="${pkgs.exa}/bin/exa -l"
      alias la="${pkgs.exa}/bin/exa -la"
      alias lx="${pkgs.exa}/bin/exa -bghHliS"
      alias lt="${pkgs.exa}/bin/exa -lT"
      export PATH="$PATH:/home/${user}/.npm-packages/bin"
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
    ".config/nvim/init.vim" = "${dotfiles}/neovim.vim";
    ".config/nvim/ginit.vim".content = ''
      Guifont ${preferedFont}:h9
    '';
    ".local/share/nvim/site/autoload/plug.vim" = "${vimPlug}/plug.vim";
    ".config/i3status/config" = "${dotfiles}/i3status";
    ".config/i3/config" = "${dotfiles}/i3.config";
    ".config/vifm/vifmrc".content = ''
      colorscheme ${vifmTheme}
    '';
    ".vim/autoload/plug.vim" = "${vimPlug}/plug.vim";
    ".vimrc" = "${dotfiles}/vimrc";
    ".gitconfig" = "${dotfiles}/gitconfig";
    ".gitignore" = "${dotfiles}/gitignore";
    ".tmux.conf" = "${dotfiles}/tmux.conf";
    ".multitailrc" = "${dotfiles}/multitailrc";
    ".elvish/rc.elv" = "${dotfiles}/rc.elv";
    ".vimperator/colors" = "${vimperatorSolarized}/colors";
    ".vimperatorrc".content = "colorscheme solarized-dark";
    ".vim/UtiliSnips/d.snippets" = "${vimDsnips}/d.snippets";
    ".themes/numix-solarized-dark" = gtkSolarized;
    ".local/share/applications/keybase.desktop".content = mkDesktop "Keybase" "env NIX_SKIP_KEYBASE_CHECKS=1 ${pkgs.keybase-gui}/bin/keybase-gui";
    ".config/fish/config.fish" = writeFishScript "config.fish" ''
      set -x GOPATH /home/$USER/go
      set -x PATH $PATH $GOPATH/bin
    '';
    ".config/fish/functions/le.fish" = writeFishAlias "le" "${pkgs.exa}/bin/exa";
    ".config/fish/functions/ll.fish" = writeFishAlias "ll" "${pkgs.exa}/bin/exa -l";
    ".config/fish/functions/la.fish" = writeFishAlias "la" "${pkgs.exa}/bin/exa -la";
    ".config/fish/functions/lx.fish" = writeFishAlias "lx" "${pkgs.exa}/bin/exa -bghHliS";
    ".config/fish/functions/lt.fish" = writeFishAlias "lt" "${pkgs.exa}/bin/exa -lT";
    ".config/oni/config.tsx".content = ''
      import * as React from "react"
      import * as Oni from "oni-api"
      export const activate = (oni: Oni.Plugin.Api) => {
          oni.editors.anyEditor.onModeChanged.subscribe((newMode) => {
              if (newMode === "insert") {
                  oni.configuration.setValues({"vim.setting.relativenumber": false})
              } else {
                  oni.configuration.setValues({"vim.setting.relativenumber": true})
              }
          })
      }
      export const configuration = {
          "ui.colorscheme": "solarized8_dark",
          "editor.fontFamily": "Fira Code",
          "oni.loadInitVim": true,
          "oni.hideMenu": true,
          "language.go.languageServer.rootFiles": [".git"],
          "language.go.languageServer.command": "/home/${user}/go/bin/go-langserver",
          "language.go.languageServer.arguments": ["-gocodecompletion", "-freeosmemory", "false"],
      }
    '';
    ".npmrc".content = ''
      prefix=/home/${user}/.npm-packages
    '';
  };
}
