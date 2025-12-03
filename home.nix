{
  config,
  pkgs,
  system,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.vintagestory-nix.homeModules.default
    ./config/lf.nix
    ./config/starship.nix
    ./config/nushell.nix
    ./config/obs.nix
  ];

  home = {
    username = "kodie";
    homeDirectory = "/home/kodie";
    stateVersion = "25.05";

    packages = import ./home-packages.nix { inherit pkgs system inputs; };

    file.".local/share/godot/export_templates" = {
      source = "${pkgs.godot-export-templates-bin}/share/godot/export_templates";
      recursive = true;
    };
  };
  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config = {
        paging = "always";
        theme = "Rose-Pine";
      };
    };
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
    direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    nvf.enable = true;
    nvf.settings = import ./config/nvf { inherit pkgs lib; };
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    lutris.enable = true;

    vs-launcher = {
      enable = true;
      settings.gameVersions = [
        # pkgs.vintagestoryPackages.latest
        (pkgs.callPackage ./custom-packages/vintagestory-cracked.nix {
          version = "1.21.5";
          hash = "sha256-jsAuu5676DXlO7tRJj5d8At/J2W3/M+zt1rpNLCIJaM=";
        })
      ];
    };

  };

  xdg.configFile = {
    "nvim-lazy" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/kodie/nixos-dotfiles/config/nvim/";
      recursive = true;
    };
    "kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/kodie/nixos-dotfiles/config/kitty/";
      recursive = true;
    };
    "bat/themes" = {
      source = ./config/bat/themes;
      recursive = true;
    };
  };

}
