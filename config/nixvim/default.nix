{ pkgs, ... }:
{
  imports = [
    ./config
    ./plugins
  ];
  config = {
    globals = {
      mapleader = " ";
    };

    clipboard.register = "unnamedplus";

    opts = {
      number = true;
      # colorcolumn = "80";
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      wrap = false;
      swapfile = false; # Undotree
      backup = false; # Undotree
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 50;
      foldlevelstart = 99;
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
      stylua # Lua formatter
      # csharpier # C# formatter
      nixfmt-rfc-style # Nix formatter
      nufmt

      # Linters
      # golangci-lint # Go linter
      shellcheck # Shell script linter
      eslint_d # JavaScript/TypeScript linter
      statix

      # Debuggers
      # netcoredbg # C# debugger
      # asm-lsp # Assembly LSP
      # delve # Go debugger
      # gcc

    ];
  };
}
