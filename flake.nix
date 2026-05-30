{
  description = "My babie's setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    inherit (nixpkgs) lib;

    system = "x86_64-linux";
    user = "tux";
    stateVersion = "25.11";

    mkHost = host: hmConfig:
      lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs user stateVersion; };
        modules = [
          ./hosts/${host}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ] ++ lib.optionals (hmConfig != null) [
          { home-manager.users.${user} = hmConfig; }
        ];
      };
  in {
    nixosConfigurations = {
      workstation = mkHost "workstation" (import ./home/workstation.nix {
        inherit user stateVersion;
      });

      server = mkHost "server" (import ./home/server.nix {
        inherit user stateVersion;
      });
    };
  };
}
