{ pkgs, lib, ... }: {
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.configurationLimit = 3;
  boot.kernelParams = [
    "quiet" "nowatchdog" "mitigations=off"
    "libata.force=noncq" "nmi_watchdog=0" "processor.max_cstate=1"
  ];

  fileSystems."/".options = [ "noatime" "nodiratime" "errors=remount-ro" ];
  boot.kernel.sysctl."vm.vfs_cache_pressure" = "50";
  boot.kernel.sysctl."vm.dirty_ratio" = "5";
  boot.kernel.sysctl."vm.dirty_background_ratio" = "2";
  boot.kernel.sysctl."vm.swappiness" = "10";

  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  services.timesyncd.enable = true;
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
  services.tlp.enable = false;

  networking.networkmanager.enable = lib.mkForce false;
  networking.useNetworkd = true;
  systemd.network = {
    enable = true;
    networks."50-dhcp" = {
      matchConfig.Name = "e*";
      networkConfig.DHCP = "yes";
      dhcpV4Config.RouteMetric = 100;
    };
  };

  networking.enableIPv6 = false;

  swapDevices = [{
    device = "/var/swap";
    size = 4096;
  }];
}
