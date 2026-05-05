{
  pkgs,
  inputs,
  ...
}:
let
  ryujinx =
    { appimageTools, fetchurl }:
    let
      pname = "ryujinx";
      version = "1.3.280";

      src = fetchurl {
        url = "https://git.ryujinx.app/Ryubing/Canary/releases/download/${version}/ryujinx-canary-${version}-x64.AppImage";
        hash = "sha256-WMJb9fsPB5hUI2SNapn6jN4+JZFhP096JVRp+iTggEg=";
      };

      contents = appimageTools.extractType2 {
        inherit pname version src;
      };
    in
    appimageTools.wrapType2 {
      inherit pname version src;
      extraPkgs =
        pkgs: with pkgs; [
          icu
          lttng-ust
        ];

      extraInstallCommands = ''
        mkdir -pv $out/share/applications $out/share/icons/hicolor/512x512/apps

        install -m 444 ${contents}/Ryujinx.desktop \
          $out/share/applications/${pname}.desktop
        install -m 444 ${contents}/Ryujinx.svg \
          $out/share/icons/hicolor/512x512/apps/${pname}.svg

        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace-fail 'Exec=Ryujinx.sh' 'Exec=${pname}' \
          --replace-fail 'Icon=Ryujinx' 'Icon=${pname}'
      '';

      meta = {
        description = "Ryujinx is an open-source Nintendo Switch emulator, originally created by gdkchan, written in C#.";
        homepage = "https://git.ryujinx.app/Ryubing";
        platforms = [ "x86_64-linux" ];
      };
    };
in
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
    (with kdePackages; callPackage ./custom-packages/plasma-smart-video-wallpaper-reborn.nix { })
    yt-dlp
    pear-desktop
    easyeffects

    # Editors / IDEs
    kdePackages.kate
    godot
    godsvg

    # Art / 3D Modeling
    krita
    aseprite # TODO: enable when not bugged
    blockbench
    blender
    # kdePackages.kdenlive

    # Games
    (callPackage ryujinx { })
    (prismlauncher.override {
      additionalPrograms = [ vlc ];
      additionalLibs = [ vlc ];
      jdks = [
        jdk25
        jdk21
        jdk17
        temurin-bin-25
        temurin-bin-21
        temurin-bin-17
      ];
    })
    (callPackage ./custom-packages/hyprism { })
    r2modman
    hydralauncher
    # vintagestoryPackages.rustique
    vintagestoryPackages.vs-launcher
    mindustry
    heroic

    # Daily Utils
    # equibop
    vesktop
    # (discord.override {
    #   withEquicord = true;
    # })
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
