{
  config,
  pkgs,
  system,
  inputs,
  ...
}:

{
  imports = [
    inputs.vintagestory-nix.homeModules.default
    inputs.nixvim.homeModules.nixvim
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
      enableBashIntegration = true;
    };
    direnv = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
    };
    bash = {
      enable = true;
      shellAliases = {
        btw = "echo I use NixOS, btw";
        vi = "nvim";
        vim = "nvim";

        gs = "git status";
        ga = "git add";
        gc = "git commit -m";
        gp = "git push";
        gb = "git branch";
        gsw = "git switch";
        gd = "git diff";
        gcl = "git clone";

        e = "exit";
        c = "clear";
        lg = "lazygit";
        gw = "./gradlew";
        cr = "cargo run";
        crq = "cr --quiet";
        cb = "cargo build";
        cbq = "cb --quiet";
        ct = "cargo test";
        ctq = "ct --quiet";
        ".." = "z ..";
        "..." = "z ../..";
        "3.." = "z ../../..";
        "4.." = "z ../../../..";
        "5.." = "z ../../../../";

        garbage-collect = "sudo nix-collect-garbage -d";
        rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
      };
    };

    # nvf.enable = true;
    # nvf.settings = import ./config/nvf { inherit pkgs lib; };
    nixvim = {
      enable = true;
      imports = [ ./config/nixvim ];
    };
    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    # };

    lutris.enable = true;

    vs-launcher = {
      enable = true;
      settings.gameVersions = [
        pkgs.vintagestoryPackages.latest
        pkgs.vintagestoryPackages.v1-21-6-rc-1
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
