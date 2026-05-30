{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-f4a0600a-7981-479d-bdd8-4ee7417329cb";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-f4a0600a-7981-479d-bdd8-4ee7417329cb".device = "/dev/disk/by-uuid/f4a0600a-7981-479d-bdd8-4ee7417329cb";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/239B-0BE2";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/luks-d5ca854b-ca6a-4009-a219-965e059d649b"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
