{ pkgs, lib, ... }: {
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;
}
