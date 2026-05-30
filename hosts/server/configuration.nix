{ lib, pkgs, ... }: {
  imports =
    [ ./hardware-configuration.nix ../../modules/nixos/server ../../modules/nixos/core ]
    ++ lib.optionals (builtins.pathExists /home/tux/.secrets/server.nix) [ (import /home/tux/.secrets/server.nix) ];

  system.activationScripts.secretsTemplate = ''
    if [ ! -f /home/tux/.secrets/server.nix ]; then
      mkdir -p /home/tux/.secrets
      cat > /home/tux/.secrets/server.nix << 'SEOF'
{ ... }: {
  home-manager.users.tux.programs.git = {
    enable = true;
    settings.user.name = "name";
    settings.user.email = "email";
  };
}
SEOF
      chown tux:users /home/tux/.secrets/server.nix
      chmod 600 /home/tux/.secrets/server.nix
      echo "created ~/.secrets/server.nix — edit then rebuild with --impure"
    fi
  '';

  networking.hostName = "server";
  system.stateVersion = "25.11";
}
