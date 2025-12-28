{ lib, pkgs, ... }:
{
  plugins.lint = {
    enable = true;
    linters = {
      statix = {
        cmd = lib.getExe pkgs.statix;
      };
    };

    lintersByFt = {
      nix = [ "statix" ];
    };
  };
}
