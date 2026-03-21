{
  pkgs,
  system,
  inputs,
  ...
}:
{
  imports = [ ./config/inkscape ];
  home.packages = with pkgs; [
    # Misc
    gh
    ripgrep
    temurin-bin
    protonup-qt
    direnv
    rose-pine-cursor
    (callPackage ./custom-packages/steam-art-manager { })
    (with kdePackages; callPackage ./custom-packages/plasma-smart-video-wallpaper-reborn.nix { })
    inputs.playit-nixos-module.packages.${system}.default
    yt-dlp
    pear-desktop
    easyeffects
    mrpack-install
    act
    kdePackages.kalgebra
    kdePackages.kcalc

    # Editors / IDEs
    jetbrains.idea-oss
    kdePackages.kate
    godot

    # Art / 3D Modeling
    krita
    # aseprite # TODO: enable when not bugged
    blockbench
    blender
    # kdePackages.kdenlive

    # Games
    (prismlauncher.override {
      additionalPrograms = [ vlc ];
      additionalLibs = [ vlc ];
    })
    (callPackage ./custom-packages/hyprism { })
    # heroic
    hydralauncher
    vintagestoryPackages.rustique
    vintagestoryPackages.vs-launcher

    # Daily Utils
    vesktop
    libreoffice-qt-fresh
    inputs.nix-alien.packages.${system}.nix-alien
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        nativeMessagingHosts = [ pkgs.firefoxpwa ];
        extraPolicies = {
          DisableTelemetry = true;
          SearchEngines = {
            Default = "ddg";
            Add = [
              {
                Name = "NixOS packages";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@no";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@nw";
              }
              {
                Name = "HomeManager options";
                URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}";
                IconURL = "https://home-manager-options.extranix.com/favicon.ico";
                Alias = "@hm";
              }
              {
                Name = "Noogle";
                URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                IconURL = "https://noogle.dev/favicon.ico";
                Alias = "@ng";
              }
              {
                Name = "Modrinth Mods";
                URLTemplate = "https://modrinth.com/discover/mods?q={searchTerms}";
                IconURL = "https://modrinth.com/favicon.ico";
                Alias = "@mods";
              }
              {
                Name = "Modrinth Shaders";
                URLTemplate = "https://modrinth.com/discover/shaders?q={searchTerms}";
                IconURL = "https://modrinth.com/favicon.ico";
                Alias = "@shaders";
              }
              {
                Name = "Modrinth Resourcepacks";
                URLTemplate = "https://modrinth.com/discover/resourcepacks?q={searchTerms}";
                IconURL = "https://modrinth.com/favicon.ico";
                Alias = "@resources";
              }
              {
                Name = "Modrinth Datapacks";
                URLTemplate = "https://modrinth.com/discover/datapacks?q={searchTerms}";
                IconURL = "https://modrinth.com/favicon.ico";
                Alias = "@datas";
              }
            ];
          };
        };
      }
    )
  ];
}
