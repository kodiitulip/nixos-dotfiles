{ pkgs, ... }:
let
  obs-wayland-hotkeys =
    {
      lib,
      stdenv,
      fetchFromGitHub,
      obs-studio,
      cmake,
      zlib,
      curl,
      dbus,
      pkg-config,
      qtbase,
      wrapQtAppsHook,
    }:
    stdenv.mkDerivation rec {
      pname = "obs-wayland-hotkeys";
      version = "1.1.0";

      src = fetchFromGitHub {
        owner = "leia-uwu";
        repo = "obs-wayland-hotkeys";
        rev = "v${version}";
        hash = "sha256-vOQfOEAnxn5vCaWpwDED1C107BB/d7T10kmKTXJ4k8k=";
      };

      nativeBuildInputs = [
        cmake
        pkg-config
        wrapQtAppsHook
      ];
      buildInputs = [
        obs-studio
        qtbase
        zlib
        curl
        dbus
      ];

      dontWrapQtApps = true;

      meta = {
        description = "OBS Studio plugin that implements the global shortcuts portal ";
        homepage = "https://github.com/leia-uwu/obs-wayland-hotkeys";
        license = lib.licenses.gpl2Only;
        maintainers = [ ];
        platforms = lib.platforms.linux;
      };
    };
in
{
  programs.obs-studio = {
    enable = true;
    plugins = [
      (with pkgs; qt6Packages.callPackage obs-wayland-hotkeys { })
    ]
    ++ (with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-tuna
    ]);
  };

}
