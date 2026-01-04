{ pkgs, ... }:
{
  imports = [
    ./config
    ./plugins
  ];
  config = {
    globals.mapleader = " ";

    clipboard.register = "unnamedplus";
    diagnostic.settings = {
      virtual_text = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      wrap = false;
      swapfile = false;
      backup = false;
      undofile = true;
      hlsearch = true;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 50;
      foldlevelstart = 99;
      foldmethod = "expr";
      fillchars = ''eob: '';
      expandtab = true;
    };
    extraPackages = with pkgs; [
      # base
      nerd-fonts.fira-mono
      fzf
      ripgrep
      fd

      # Formatters
      stylua
      nixfmt-rfc-style
      nufmt

      # Linters
      shellcheck # Shell script linter
      eslint_d # JavaScript/TypeScript linter
      statix
    ];
  };
}
