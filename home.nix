{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.vintagestory-nix.homeModules.default
    inputs.nixvim.homeModules.nixvim
    ./home-packages.nix
    ./config
  ];

  home = {
    username = "kodie";
    homeDirectory = "/home/kodie";
    stateVersion = "25.05";

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

        dedup = "nix store optimise";
        garbage-collect = "sudo nix-collect-garbage -d";
        rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
      };

    };

    obsidian.enable = true;
    nixvim = {
      enable = true;
      imports = [ ./config/nixvim ];
    };

    lutris.enable = true;

    vs-launcher = {
      enable = true;
      settings.gameVersions = with pkgs.vintagestoryPackages; [
        latest
        v1-21-1
        v1-22
      ];
    };

  };

  xdg = {
    configFile = {
      "kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/kodie/nixos-dotfiles/config/kitty/";
        recursive = true;
      };
      "bat/themes" = {
        source = ./config/bat/themes;
        recursive = true;
      };
    };
  };

}
