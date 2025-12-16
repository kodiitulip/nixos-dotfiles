{
  pkgs,
  system,
  inputs,
  ...
}:
with pkgs;
[
  gh
  ripgrep
  godot
  temurin-bin
  inputs.zen-browser.packages."${system}".default
  vesktop
  easyeffects
  inputs.playit-nixos-module.packages."${system}".default
  protonup-qt
  vscodium-fhs
  jetbrains.idea-community
  kdePackages.kate
  prismlauncher
  mindustry
  blockbench
  blender
  heroic
  krita
  direnv
  kdePackages.partitionmanager
  kdePackages.kdialog
  packwiz
  aseprite
  libreoffice-qt-fresh
  hydralauncher
  youtube-music
  rose-pine-cursor

  # vintagestoryPackages.latest
  vintagestoryPackages.rustique
  vintagestoryPackages.vs-launcher

  (callPackage ./custom-packages/steam-art-manager.nix {})
]
