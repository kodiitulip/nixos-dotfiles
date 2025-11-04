{
  description = "My NixOS Flake";

  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      zen-browser,
      playit-nixos-module,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          # playit-nixos-module.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kodie.imports = [ ./home.nix ];
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs;
                system = "x86_64-linux";
              };
            };
          }
        ];
      };
    };
}
