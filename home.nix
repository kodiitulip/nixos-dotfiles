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
