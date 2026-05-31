{ ... }: {
  # ── No GUI / Desktop ──
  services.xserver.enable = false;
  services.dbus.enable = true;

  # ── Disable unnecessary services ──
  services.avahi.enable = false;
  services.printing.enable = false;
  services.udisks2.enable = false;
  services.upower.enable = false;
  services.thermald.enable = false;
  services.power-profiles-daemon.enable = false;
  services.system-config-printer.enable = false;
  services.opensnitch = { };

  hardware.bluetooth.enable = false;
  services.pulseaudio.enable = false;
  hardware.sane.enable = false;
  hardware.enableRedistributableFirmware = false;

  # ── Remove unnecessary packages ──
  environment.defaultPackages = [ ];
  documentation.enable = false;
  documentation.doc.enable = false;
  documentation.info.enable = false;
  documentation.man.enable = false;
  documentation.nixos.enable = false;

  # ── Kernel hardening ──
  boot.kernel.sysctl = {
    # IP spoofing protection
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.default.rp_filter" = "1";

    # Ignore ICMP redirects
    "net.ipv4.conf.all.accept_redirects" = "0";
    "net.ipv6.conf.all.accept_redirects" = "0";
    "net.ipv4.conf.all.secure_redirects" = "0";
    "net.ipv4.conf.default.accept_redirects" = "0";
    "net.ipv6.conf.default.accept_redirects" = "0";
    "net.ipv4.conf.default.secure_redirects" = "0";
    "net.ipv4.conf.all.send_redirects" = "0";
    "net.ipv4.conf.default.send_redirects" = "0";

    # Ignore source-routed packets
    "net.ipv4.conf.all.accept_source_route" = "0";
    "net.ipv6.conf.all.accept_source_route" = "0";
    "net.ipv4.conf.default.accept_source_route" = "0";
    "net.ipv6.conf.default.accept_source_route" = "0";

    # SYN flood protection
    "net.ipv4.tcp_syncookies" = "1";
    "net.ipv4.tcp_syn_retries" = "2";
    "net.ipv4.tcp_synack_retries" = "2";

    # Magic system request key
    "kernel.sysrq" = "0";

    # Core dumps
    "kernel.core_uses_pid" = "0";
    "fs.suid_dumpable" = "0";

    # Restrict dmesg
    "kernel.dmesg_restrict" = "0";
    "kernel.kptr_restrict" = "2";

    # ASLR
    "kernel.randomize_va_space" = "2";

    # Hard link / symlink protection
    "fs.protected_hardlinks" = "1";
    "fs.protected_symlinks" = "1";

    # BPF
    "kernel.unprivileged_bpf_disabled" = "1";

    # YAMA
    "kernel.yama.ptrace_scope" = "2";

    # TCP hardening
    "net.ipv4.tcp_rfc1337" = "1";
    "net.ipv4.tcp_timestamps" = "0";

    # Disable Kexec
    "kernel.kexec_load_disabled" = "1";
  };

  # ── Disable coredump ──
  systemd.coredump.enable = false;

  # ── Disable SUID binaries (some) ──
  security.wrappers = { };

  # ── AppArmor ──
  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;

  # ── Lock root account ──
  users.users.root.hashedPassword = "!";
  users.users.root.openssh.authorizedKeys.keys = [ ];

  # ── Protect kernel image ──
  boot.kernelParams = [
    "slab_nomerge"
    "init_on_alloc=1"
    "init_on_free=1"
    "page_alloc.shuffle=1"
    "randomize_kstack_offset=on"
    "vsyscall=none"
    "debugfs=off"
    "module.sig_enforce=1"
    "lockdown=confidentiality"
  ];
}
