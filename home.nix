{
  config,
  pkgs,
  system,
  inputs,
  lib,
  ...
}:

let 
  steam-art-manager = import ./custom-packages/steam-art-manager.nix { inherit pkgs; };
in 
{
  imports = [
    ./config/lf.nix
  ];

  home = {
    username = "kodie";
    homeDirectory = "/home/kodie";
    stateVersion = "25.05";

    packages = import ./home-packages.nix { inherit pkgs system inputs; };
  };
  programs = {
    home-manager.enable = true;
    nushell = {
      enable = true;
      shellAliases = {
        btw = "echo I use NixOS, btw";
        vi = "nvim";
      };
      configFile.source = ./config/nushell/config.nu;
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    starship = import ./config/starship.nix;
    nvf.enable = true;
    nvf.settings = import ./config/nvf { inherit pkgs lib; };
    neovim = {
      enable = true;
      defaultEditor = true;
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
    "yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/kodie/nixos-dotfiles/config/yazi/";
      recursive = true;
    };
    "bat/themes" = {
      source = ./config/bat/themes;
      recursive = true;
    };
  };

}
