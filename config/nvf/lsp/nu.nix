{ pkgs, lib, ... }:

{
  vim.languages.rust = {
    enable = true;
    crates.enable = true;
    lsp.enable = true;
    lsp.opts = ''
      ['rust-analyzer'] = {
        cargo = {allFeature = true},
        checkOnSave = true,
        procMacro = {
          enable = true,
        },
      },
    '';
    treesitter.enable = true;
  };
}


