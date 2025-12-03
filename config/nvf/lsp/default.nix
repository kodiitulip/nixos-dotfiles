{ pkgs, lib, ... }:

{
  imports = [
    ./nix.nix
    ./rust.nix
    ./typescript.nix
  ];
  vim = {
    lsp = {
      lspkind.enable = true;

      trouble.enable = true;
      trouble.setupOpts = {
        modes.lsp.win.position = "right";
      };
      lspconfig.enable = true;
      formatOnSave = true;
      mappings = {
        codeAction = "<leader>ca";
        format = "<leader>cf";
        goToDeclaration = "gD";
        goToDefinition = "gd";
        goToType = "gt";
        hover = "K";
        listDocumentSymbols = "gS";
        listImplementations = "gI";
        listReferences = "gr";
        nextDiagnostic = "gn";
        previousDiagnostic = "gp";
        renameSymbol = "<leader>cr";
      };

    };

    formatter.conform-nvim.enable = true;

    keymaps = [
      {
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        desc = "Diagnostics (Trouble)";
        mode = "n";
      }
      {
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        desc = "Buffer Diagnostics (Trouble)";
        mode = "n";
      }
      {
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle<cr>";
        desc = "Symbols (Trouble)";
        mode = "n";
      }
      {
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        desc = "Quickfix List (Trouble)";
        mode = "n";
      }
      {
        key = "<leader>cS";
        action = "<cmd>Trouble lsp toggle<cr>";
        desc = "LSP references/definitions/... (Trouble)";
        mode = "n";
      }
      {
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        desc = "Location List (Trouble)";
        mode = "n";
      }
    ];
  };
}
