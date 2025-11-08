{ pkgs, lib, ... }:

{
  imports = [
    ./lsp/conform.nix
    ./lsp/fidget.nix
    ./lsp/lsp.nix
    ./keymaps.nix
    ./treesitter.nix
    ./toggleterm.nix
    ./themes.nix
    ./lazygit.nix
    ./lualine.nix
    ./dashboard.nix
    ./bufferline.nix
    ./snacks.nix
    ./gitsigns.nix
    ./whichkey.nix
    ./hlchunk.nix
    ./yanky.nix
    ./autopairs.nix
    ./blink-cmp.nix
    ./smear-cursor.nix
    ./nix-develop.nix
    ./aerial.nix
    ./autosave.nix
    ./notify.nix
    ./barbecue.nix
    ./noice.nix
    ./neoscroll.nix
    ./zen-mode.nix
    ./yazi.nix
    ./ts-comments.nix
    ./timerly.nix
    ./treesj.nix
    ./web-devicons.nix
  ];
  config = {
    globals = {
      mapleader = " ";
    };

    opts = {
      number = true;
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
    };
    extraPackages = with pkgs; [
      nerd-fonts.jetbrains-mono
      fzf
      ripgrep
      fd
      stylua
      nixfmt-rfc-style
      shellcheck
      eslint_d
      prettierd
    ];
  };
}
