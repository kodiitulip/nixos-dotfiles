{ lib, pkgs, ... }:
{
  plugins.lint = {
    enable = true;
    linters = {
      statix.cmd = lib.getExe pkgs.statix;
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

  autoCmd = [
    {
      event = [
        "InsertLeave"
        "TextChanged"
      ];
      callback.__raw = ''function() require('lint').try_lint() end'';
      desc = "Lint when TextChanged or InsertLeave";
    }
  ];
}
