{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bun
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
    jellyfin-ffmpeg
    gdu
    kdePackages.qtmultimedia
    firefoxpwa
    catt
    croc
    ethtool
    icu
    inputs.agenix.packages."x86_64-linux".default
    # inputs.playit-nixos-module.packages."x86_64-linux".playit-cli
  ];
}
