{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # copyparty.url = "github:9001/copyparty";
    nix-alien.url = "github:thiagokokada/nix-alien";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
    nixvim.url = "github:nix-community/nixvim";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vintagestory-nix = {
      url = "github:PierreBorine/vintagestory-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      playit-nixos-module,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          playit-nixos-module.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kodie.imports = [ ./home.nix ];
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs system; };
            };
          }
        ];
      };
    };
}
