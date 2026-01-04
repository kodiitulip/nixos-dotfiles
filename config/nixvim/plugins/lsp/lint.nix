{ lib, pkgs, ... }:
{
  plugins.lint = {
    enable = true;
    linters = {
      statix = {
        cmd = lib.getExe pkgs.statix;
      };
      eslint_d = {
        cmd = lib.getExe pkgs.eslint_d;
      };
      vale.cmd = lib.getExe pkgs.vale;
    };

    lintersByFt = {
      nix = [ "statix" ];
      javascript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      typescript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      markdown = [ "vale" ];
    };
  };
}
