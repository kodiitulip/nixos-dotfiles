{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./fidget.nix
    ./conform.nix
    ./lint.nix
  ];
  plugins = {
    lsp-lines.enable = true;
    lsp-format.enable = true;
    lint.enable = true;
    helm.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        superhtml.enable = true;
        sqls.enable = true;
        nushell.enable = true;
        lua_ls.enable = true;
        nil_ls.enable = true;
        ts_ls.enable = true;
        rust_analyser.enable = true;
        marksman.enable = true;
        pyright.enable = true;
        jsonls.enable = true;
        tailwindcss.enable = true;
        helm_ls = {
          enable = true;
          extraOptions = {
            settings = {
              "helm_ls" = {
                yamlls = {
                  path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
                };
              };
            };
          };
        };
        yamlls = {
          enable = true;
          extraOptions = {
            settings = {
              yaml = {
                schemas = {
                  kubernetes = "'*.yaml";
                  "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
                  "http://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
                  "http://json.schemastore.org/ansible-stable-2.9" = "roles/tasks/*.{yml,yaml}";
                  "http://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
                  "http://json.schemastore.org/ansible-playbook" = "*play*.{yml,yaml}";
                  "http://json.schemastore.org/chart" = "Chart.{yml,yaml}";
                  "https://json.schemastore.org/dependabot-v2" = ".github/dependabot.{yml,yaml}";
                  "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" =
                    "*docker-compose*.{yml,yaml}";
                  "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" =
                    "*flow*.{yml,yaml}";
                };
              };
            };
          };
        };
      };

    };
  };

  lsp.keymaps = [
    {
      key = "gd";
      lspBufAction = "definition";
    }
    {
      key = "gD";
      lspBufAction = "references";
    }
    {
      key = "gt";
      lspBufAction = "type_definition";
    }
    {
      key = "gi";
      lspBufAction = "implementation";
    }
    {
      key = "K";
      lspBufAction = "hover";
    }
    {
      action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
      key = "<leader>k";
    }
    {
      action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
      key = "<leader>j";
    }
    {
      action = "<CMD>LspStop<Enter>";
      key = "<leader>lx";
    }
    {
      action = "<CMD>LspStart<Enter>";
      key = "<leader>ls";
    }
    {
      action = "<CMD>LspRestart<Enter>";
      key = "<leader>lr";
    }
  ];

  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float = { border = _border }
    }

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
}
