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
  (with kdePackages; callPackage ./custom-packages/plasma-smart-video-wallpaper-reborn.nix { })
  kdePackages.qtmultimedia
  inputs.playit-nixos-module.packages.${system}.default
  yt-dlp

  # Editors / IDEs
  vscodium-fhs
  jetbrains.idea-oss
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
  inputs.zen-browser.packages.${system}.default
]
