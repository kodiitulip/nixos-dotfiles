{
  pkgs,
  system,
  inputs,
  ...
}:
with pkgs;
[
  # Misc
  gh
  ripgrep
  temurin-bin
  protonup-qt
  direnv
  kdePackages.partitionmanager
  kdePackages.kdialog
  rose-pine-cursor
  (callPackage ./custom-packages/steam-art-manager.nix { })
  inputs.playit-nixos-module.packages."${system}".default

  # Editors / IDEs
  vscodium-fhs
  jetbrains.idea-community
  kdePackages.kate
  poedit
  godot

  # Art / 3D Modeling
  krita
  aseprite
  blockbench
  blender

  # Games
  prismlauncher
  mindustry
  heroic
  hydralauncher
  rimsort
  vintagestoryPackages.rustique
  vintagestoryPackages.vs-launcher

  # Daily Utils
  vesktop
  easyeffects
  youtube-music
  libreoffice-qt-fresh
  inputs.zen-browser.packages."${system}".default
]
