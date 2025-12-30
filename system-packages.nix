{ pkgs, inputs, ... }:
with pkgs;
[
  kitty
  vlc
  wl-clipboard-rs
  zip
  unzip
  p7zip
  rar
  gamemode
  wine-wayland
  winetricks
  sops
  fd
  cabextract
  jellyfin-ffmpeg
  trashy
  dotnetCorePackages.runtime_8_0-bin
  libnotify
]
