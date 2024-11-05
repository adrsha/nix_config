# home-manager build --option fallback true

{ config, pkgs, inputs, ... }:

{

# Home Manager needs a bit of information about you and the paths it should
# manage.
  home.username = "chilly";
  home.homeDirectory = "/home/chilly";

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

# The home.packages option allows you to install Nix packages into your
# environment.

  home.packages = with pkgs; [

    tldr


# System Utilities
    blueberry
      brightnessctl
      dunst
      gnumake
      nix-search-cli
      xorg.xset
      udiskie
      libnotify
      killall

# System Monitoring
      btop
      neofetch

# Terminal Utilities
      alacritty
      fzf
      fd
      bat
      ripgrep
      zoxide
      lsd
      clipse

# Development Tools
      cargo
      cmake
      ninja
      python3
      python312Packages.numpy

# Programming Languages and Toolchains
      flutter

# Language Servers
      vscode-langservers-extracted
      cpplint
      lua-language-server
      clang
      pyright
      typescript-language-server
      nil
      jq-lsp
      bash-language-server
      rust-analyzer

# Plugins
      fishPlugins.tide

# Qt and UI Libraries
      qt5.full
      inputs.prism.packages.${system}.default

# Desktop Environment Tools
      ags
      hyprpicker
      grim
      slurp
      playerctl

# Multimedia
      mpv

# Compression and Archiving
      unzip

# Browsers and Internet
      firefox
      qbittorrent

# Game Engines
      godot_4
  ];



  home.file."${config.xdg.configHome}/nvim" = {
    source = ./nvim-perf;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/ags" = {
    source = ./ags;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/lsd" = {
    source = ./lsd;
    recursive = true;
  };

   # ags using the nixpkgs overlay
  nixpkgs.overlays = [
    (final: prev:
     {
     ags = prev.ags.overrideAttrs (old: {
         buildInputs = old.buildInputs ++ [ pkgs.libdbusmenu-gtk3 ];
         });
     })
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    DISPLAY = ":0";
  };
  home.sessionPath = [
    "$HOME/Scripts/"
    "$HOME/.cargo/bin"
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -U fish_greeting
      export GBM_BACKEND=amdgpu;
      export GDK_SCALE="1";
      export HYRCURSOR_SIZE="24";
      export HYRCURSOR_THEME="Bibata-Modern_Classic";
      export HYRCURSOR_TRACE="1";
      export LIBVA_DRIVER_NAME="radeonsi";
      export MOZ_ENABLE_WAYLAND="1";
      export NIXOS_OZONE_WL="1";
      export QT_PLUGIN_PATH="${pkgs.qt5.qtbase.bin}/lib/qt-5/plugins";
      export QT_QPA_PLATFORM="wayland;xcb";
      export QT_QPA_PLATFORMTHEME="qt6ct";
      export RUST_BACKTRACE="full";
      export FZF_DEFAULT_OPTS="--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1 --wrap --gap=1 --no-separator --pointer=✦ --color=16 --color='gutter:-1,fg+:2,fg:7'";
      export VDPAU_DRIVER="radeonsi";
      export WLR_DRM_DEVICES="/dev/dri/card1:/dev/dri/card0";  
      export WLR_DRM_NO_ATOMIC="1";
      export XCURSOR_SIZE="24";
      export XDG_CONFIG_HOME="$HOME/.config";
      export XDG_CURRENT_DESKTOP="Hyprland";
      export XDG_SESSION_DESKTOP="Hyprland";
      export XDG_SESSION_TYPE="wayland";
      export __GL_GSYNC_ALLOWED="0";
      export __GL_VRR_ALLOWED="0";

      fish_vi_key_bindings

      set fish_cursor_insert line
      set fish_cursor_default block
      set fish_cursor_visual block

      function ni
        nix-search $argv | fzf | awk '{print $1}' | while read -l package;
              nix-env -iA "nixos.$package" || nix-env -iA "nixpkgs.$package" || echo "Package $package not found in nixpkgs or nixos.";
            end
      end

      function fish_user_key_bindings
      bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
      end

      zoxide init fish --cmd c| source
      '';
# shellInit = ''
# '';
  };

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
