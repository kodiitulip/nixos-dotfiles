{ pkgs, lib, ... }:

{
  vim.languages.ts = {
    enable = true;
    extensions.ts-error-translator.enable = true;
    extraDiagnostics.enable = true;
    format.enable = true;
    lsp.enable = true;
    treesitter.enable = true;
  };
  
  vim.languages.html = {
    enable = true;
    treesitter.enable = true;
    treesitter.autotagHtml = true;
  };

}