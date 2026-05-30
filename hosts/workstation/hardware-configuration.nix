{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-f5d0e2ec-ba22-434e-920a-c859cfd902bd";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-f5d0e2ec-ba22-434e-920a-c859cfd902bd".device = "/dev/disk/by-uuid/f5d0e2ec-ba22-434e-920a-c859cfd902bd";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9561-4962";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/luks-6cc7b32c-be55-4c84-ad96-4f6f8379ef0e"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
