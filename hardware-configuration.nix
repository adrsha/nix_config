# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a8ee74da-31ee-492b-b3d6-22d4402531c7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/CBB0-1E2F";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/hdd2" =
    { device = "/dev/disk/by-uuid/ddda81c1-71b6-454a-8586-b5c3c55746f3";
      fsType = "ext4";
    };

  fileSystems."/hdd1" =
    { device = "/dev/disk/by-uuid/1f26892b-665a-4d31-880a-2eee2e33a56b";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/03a5a51d-7832-474a-9b90-9dcdb96775a0"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
