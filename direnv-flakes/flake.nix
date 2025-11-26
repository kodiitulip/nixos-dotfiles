{
  description = "Running Godot prebuilt binaries with this flake and direnv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    fhs = pkgs.buildFHSEnv {
      name = "fhs-shell";
      targetPkgs = pkgs: with pkgs; [
        fontconfig
        wayland
        libx11
        libdecor
        libxcursor
        libxext
        libxfixes
        libxi
        libxinerama
        libxkbcommon
        libxrandr
        libxrender
        alsa-lib
        libGL
        vulkan-loader
        fontconfig.lib
        libpulseaudio
        speechd-minimal
        udev
      ];
      runScript = "";
    };
  in
  {
    devShells.${system}.default = fhs.env;
  };
}