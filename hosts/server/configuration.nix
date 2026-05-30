{ lib, pkgs, ... }: {
  imports =
    [ ./hardware-configuration.nix ../../modules/nixos/server ../../modules/nixos/core ]
    ++ lib.optionals (builtins.pathExists /home/server/.secrets/server.nix) [ (import /home/server/.secrets/server.nix) ];

  system.activationScripts.secretsTemplate = ''
    if [ ! -f /home/server/.secrets/server.nix ]; then
      mkdir -p /home/server/.secrets
      cat > /home/server/.secrets/server.nix << 'SEOF'
{ ... }: {
  home-manager.users.tux.programs.git = {
    enable = true;
    settings.user.name = "name";
    settings.user.email = "email";
  };
}
SEOF
      chown server:users /home/server/.secrets/server.nix
      chmod 600 /home/server/.secrets/server.nix
      echo "created ~/.secrets/server.nix — edit then rebuild with --impure"
    fi
  '';

  networking.hostName = "server";
  system.stateVersion = "25.11";
}
