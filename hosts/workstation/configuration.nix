{ lib, pkgs, ... }:
{
  imports =
    [ ./hardware-configuration.nix ../../modules/nixos/desktop ../../modules/nixos/core ]
    ++ lib.optionals (builtins.pathExists /home/tux/.secrets/workstation.nix) [ (import /home/tux/.secrets/workstation.nix) ];

  system.activationScripts.secretsTemplate = ''
    if [ ! -f /home/tux/.secrets/workstation.nix ]; then
      mkdir -p /home/tux/.secrets
      cat > /home/tux/.secrets/workstation.nix << 'SEOF'
{ ... }: {
  home-manager.users.tux.programs.git = {
    enable = true;
    settings.user.name = "name";
    settings.user.email = "email";
  };
}
SEOF
      chown tux:users /home/tux/.secrets/workstation.nix
      chmod 600 /home/tux/.secrets/workstation.nix
      echo "created ~/.secrets/workstation.nix — edit then rebuild with --impure"
    fi
  '';

  networking.hostName = "workstation";

  system.stateVersion = "25.11";
}

