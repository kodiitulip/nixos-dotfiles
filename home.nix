{
  config,
  pkgs,
  system,
  inputs,
  ...
}:

{
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
    nixvim.imports = [ ./config/nixvim ];
    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #
    #   withNodeJs = true;
    #   withPython3 = true;
    #   withRuby = true;
    #
    #   extraPackages = with pkgs; [
    #     doq
    #     sqlite
    #     cargo
    #     clang
    #     cmake
    #     gcc
    #     gnumake
    #     ninja
    #     pkg-config
    #     yarn
    #   ];
    #
    #   extraLuaPackages = ls: with ls; [ luarocks ];
    # };
  };

  xdg.configFile = {
    "nvim" = {
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
  };

}
