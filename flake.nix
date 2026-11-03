{
  description = "uedaeita's macOS environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      determinate,
      ...
    }:
    {
      darwinConfigurations."pollock" = nix-darwin.lib.darwinSystem {
        modules = [
          determinate.darwinModules.default
          ./nix/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.uedaeita = import ./nix/home;
            };
          }
        ];
      };
    };
}
