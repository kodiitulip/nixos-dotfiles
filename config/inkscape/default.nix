{ pkgs, ... }:
let
  extra-extensions = pkgs.callPackage ./extensions.nix { };
in
{
  home.packages = with pkgs; [
    inkscape-with-extensions.override
    {
      inkscapeExtensions = with pkgs; [
        inkscape-extensions.applytransforms
        extra-extensions.godot-tools
      ];
    }
  ];
}
