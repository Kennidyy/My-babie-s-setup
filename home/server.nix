{ user, stateVersion }: {
  imports = [ ./pkgs.nix ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    inherit stateVersion;
  };
}
