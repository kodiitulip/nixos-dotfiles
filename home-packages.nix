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
  pear-desktop

  # Editors / IDEs
  # jetbrains.idea-oss
  kdePackages.kate
  godot

  # Art / 3D Modeling
  krita
  aseprite
  blockbench
  blender
  kdePackages.kdenlive

  # Games
  prismlauncher
  heroic
  hydralauncher
  rimsort
  vintagestoryPackages.rustique
  vintagestoryPackages.vs-launcher
  inputs.hytale-launcher.packages.x86_64-linux.default

  # Daily Utils
  vesktop
  libreoffice-qt-fresh
  inputs.zen-browser.packages.${system}.default
  inputs.nix-alien.packages.${system}.nix-alien
]
