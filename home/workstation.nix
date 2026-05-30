{ user, stateVersion }: {
  imports = [ ./modules/default.nix ./pkgs.nix ];

  modules.nvim.enable = true;
  modules.nvim.copilot.enable = false;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    inherit stateVersion;
  };
}
