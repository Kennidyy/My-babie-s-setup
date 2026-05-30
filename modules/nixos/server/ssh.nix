{ ... }: {
  # ── Firewall ──
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 2222 ];
    rejectPackets = true;
  };

  # ── SSH - max security ──
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      ChallengeResponseAuthentication = false;
      PubkeyAuthentication = true;
      PermitRootLogin = "no";
      MaxAuthTries = 2;
      MaxSessions = 2;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 0;
      LoginGraceTime = 30;
      AllowTcpForwarding = "no";
      X11Forwarding = false;
      PermitTunnel = "no";
      AllowAgentForwarding = "no";
      PermitUserRC = false;
      Compression = "no";
      TCPKeepAlive = "no";
      Ciphers = [ "chacha20-poly1305@openssh.com" "aes256-gcm@openssh.com" ];
      Macs = [ "hmac-sha2-512-etm@openssh.com" "umac-128-etm@openssh.com" ];
      KexAlgorithms = [ "curve25519-sha256@libssh.org" "diffie-hellman-group16-sha512" ];
      HostKeyAlgorithms = "ssh-ed25519,sk-ssh-ed25519@openssh.com";
      RekeyLimit = "1G 1h";
      LogLevel = "VERBOSE";
      SyslogFacility = "AUTH";
      PrintMotd = false;
      PrintLastLog = true;
      AllowUsers = [ "tux" ];
  };
  };

  # ── Fail2ban ──
  services.fail2ban = {
    enable = true;
    maxretry = 3;
    bantime = "24h";
  };
}
