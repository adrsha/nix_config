# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  programs.adb.enable = true;
  programs.npm.enable = true;
  programs.java.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    at-spi2-core
      boost
      cairo
      udisks
      curl
      dbus
      fmt
      fuse3
      glib
      glibc
      graphite2
      gtk3
      gtk3-x11
      harfbuzz
      libdbusmenu-gtk3
      libepoxy
      libselinux
      libsepol
      libstdcxx5
      libxkbcommon
      openssl                                                                                                                                                                                                                           
      pango
      pcre
      qt5.qtbase
      qt5.qtwayland
      stdenv.cc.cc
      stdenv.cc.cc.lib
      util-linux
      xorg.libX11
      xorg.libXcursor                                                                                                                                                                                                                   
      xorg.libXdmcp
      xorg.libXi                                                                                                                                                                                                                        
      xorg.libXtst
      xorg.libxcb                                                                                                                                                                                                                       
      zlib
      ];

  boot.kernelParams = [
    "radeon.si_support=0"  # Disable old radeon driver for Southern Islands
      "amdgpu.si_support=1"  # Enable amdgpu driver for Southern Islands
      "amdgpu.dc=1"         # Enable display core
      "amdgpu.ppfeaturemask=0xffffffff"  # Enable all power features
  ];
  boot.blacklistedKernelModules = [ "radeon" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  
  # services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.supergfxd.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    time.timeZone = "Asia/Kathmandu";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "LatArCyrHeb-16";
    earlySetup = true;
    enable = true;
    useXkbConfig = true; # use xkb.options in tty.
      colors = [
      "000000"
        "232a2d"
        "8ccf7e"
        "e5c76b"
        "e57474"
        "67b0e8"
        "8ccf7e"
        "eee8d5"
        "2d3437"
        "8ccf7e"
        "6cbfbf"
        "e57474"
        "67cbe7"
        "c47fd5"
        "bdc3c2"
        "fdf6e3"
      ];
  };


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
  ];

# Enable the X11 windowing system.
# services.xserver.enable = true;

# Enable sound.
# security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

# Enable touchpad support (enabled default in most desktopManager).
  security.sudo.extraRules= [
  {  users = [ "chilly" ];
    commands = [
    { command = "ALL" ;
      options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
    }
    ];
  }
  ];

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.fish;
  users.users.chilly = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

# List packages installed in system profile. To search, run:
  environment = {
    shellAliases = {
      cp = "cp -ir";
      mv = "mv -i";
      mkdir = "mkdir -p";
      l = "lsd -L";
      ls = "lsd -L";
      la = "lsd -A";
      ll = "lsd -lA --date relative --sort git";
      lt = "lsd --tree";
      lr = "lsd -R";
      f = "cd $(fd ~ | fzf)";
      o = "~/Scripts/launch";
      n = "nvim";
      t = "nvim ~/Notes/todo.md";
      nc = "nvim ~/flakes/";
      nm = "sudo nmtui";
      ns = "nix-search -dr";
      ins = "nix-env -iA";
      uni = "nix-env --uninstall";
      rr = "sudo nixos-rebuild switch --flake $HOME/flakes/ && home-manager switch --flake ~/flakes/";
      nr = "sudo nixos-rebuild switch --flake $HOME/flakes/";
      hr = "home-manager switch --flake $HOME/flakes/";
      gpush = "cat ~/Documents/gittoken | wl-copy; git push origin $(git branch --show-current)";
    };

    systemPackages = with pkgs; [
      neovim 
        curl
        wget
        git
        gcc      
        wl-clipboard-rs
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        libGLU
        glxinfo
        radeontop
        supergfxctl
        file
        llvmPackages_latest.clang-tools
        llvmPackages_latest.libcxx
        lua53Packages.jsregexp
    ];
    sessionVariables = {
    };
  };


  nix.settings.experimental-features = ["nix-command" "flakes"];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
  programs.gamemode.enable = true;
  programs.hyprland = {
    xwayland.enable = true;
    enable = true;
  };
  programs.fish = {
    enable = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk];

  hardware = {
    bluetooth.enable = true;

    graphics.enable = true;
    graphics.enable32Bit = true; # Support Direct Rendering for 32-bit applications (such as Wine) on 64-bit systems
      graphics.extraPackages = with pkgs; [ 
      amdvlk 
      vulkan-tools
      vulkan-validation-layers
      libGL
      ];
    graphics.extraPackages32 = [ pkgs.driversi686Linux.amdvlk ]; 
  };


# To be sure nvidia is not being used
  hardware.nvidia.modesetting.enable = false;  # Make sure NVIDIA prime isn't interfering

# Enable PRIME for hybrid graphics
    hardware.nvidia.prime = {
      offload.enable = false;  # We don't want NVIDIA-style offloading
        sync.enable = false;     # We don't want NVIDIA-style sync
    };

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

