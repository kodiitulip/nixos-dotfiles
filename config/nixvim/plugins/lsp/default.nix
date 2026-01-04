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
  lsp = {
    inlayHints.enable = true;
    keymaps = [
      {
        key = "<leader>cl";
        action.__raw = "function() Snacks.picker.lsp_config() end";
        options.desc = "Lsp Info";
      }
      {
        key = "gd";
        # action.__raw = "vim.lsp.buf.definition";
        options.desc = "Goto Definition";
        lspBufAction = "definition";
      }
      {
        key = "gr";
        # action.__raw = "vim.lsp.buf.references";
        options = {
          desc = "References";
          nowait = true;
        };
        lspBufAction = "references";
      }
      {
        key = "gI";
        # action.__raw = "vim.lsp.buf.implementation";
        options.desc = "Goto Implementation";
        lspBufAction = "implementation";
      }
      {
        key = "gy";
        # action.__raw = "vim.lsp.buf.type_definition";
        options.desc = "Goto T[y]pe Definition";
        lspBufAction = "type_definition";
      }
      {
        key = "gD";
        # action.__raw = "vim.lsp.buf.declaration";
        options.desc = "Goto Declaration";
        lspBufAction = "declaration";
      }
      {
        key = "K";
        action = "<cmd>Lspsaga hover_doc<cr>";
        options.desc = "Hover";
        # lspBufAction = "hover";
      }
      {
        key = "gK";
        # action.__raw = "function() return vim.lsp.buf.signature_help() end";
        options.desc = "Signature Help";
        lspBufAction = "signature_help";
      }
      {
        key = "<c-k>";
        # action.__raw = "function() return vim.lsp.buf.signature_help() end";
        mode = [ "i" ];
        options.desc = "Signature Help";
        lspBufAction = "signature_help";
      }
      {
        key = "<leader>ca";
        # action.__raw = "vim.lsp.buf.code_action";
        options.desc = "Code Action";
        mode = [
          "n"
          "x"
        ];
        lspBufAction = "code_action";
      }
      {
        key = "<leader>cc";
        action.__raw = "vim.lsp.codelens.run";
        options.desc = "Run Codelens";
        mode = [
          "n"
          "x"
        ];
      }
      {
        key = "<leader>cC";
        action.__raw = "vim.lsp.codelens.refresh";
        options.desc = "Refresh & Display Codelens";
        mode = [ "n" ];
      }
      {
        key = "<leader>cR";
        action.__raw = "function() Snacks.rename.rename_file() end";
        options.desc = "Rename File";
        mode = [ "n" ];
      }
      {
        key = "<leader>cr";
        # action.__raw = "vim.lsp.buf.rename";
        options.desc = "Rename";
        lspBufAction = "rename";
      }
      {
        key = "<leader>cd";
        options.desc = "Show diagnostics under the cursor";
        action.__raw = "function() vim.diagnostic.open_float() end";
      }
      {
        key = "]]";
        action.__raw = "function() Snacks.words.jump(vim.v.count1) end";
        options.desc = "Next Reference";
      }
      {
        key = "[[";
        action.__raw = "function() Snacks.words.jump(-vim.v.count1) end";
        options.desc = "Prev Reference";
      }
      {
        key = "<a-n>";
        action.__raw = "function() Snacks.words.jump(vim.v.count1, true) end";
        options.desc = "Next Reference";
      }
      {
        key = "<a-p>";
        action.__raw = "function() Snacks.words.jump(-vim.v.count1, true) end";
        options.desc = "Prev Reference";
      }

      {
        key = "<leader>ss";
        action.__raw = ''function() Snacks.picker.lsp_symbols() end'';
        options.desc = "LSP Symbols";
      }
      {
        key = "<leader>sS";
        action.__raw = ''function() Snacks.picker.lsp_workspace_symbols() end'';
        options.desc = "LSP Workspace Symbols";
      }
    ];
    servers = {
      "*" = {
        enable = true;
        config = {
          capabilities = {
            workspace.fileOperations = {
              didRename = true;
              willRename = true;
            };
            textDocument.semanticTokens.multilineTokenSupport = true;
          };
          root_markers = [ ".git" ];
        };
      };
      superhtml.enable = true;
      sqls.enable = true;
      nushell.enable = true;
      lua_ls.enable = true;
      nil_ls.enable = true;
      ts_ls.enable = true;
      emmet_language_server.enable = true;
      tailwindcss.enable = true;
      rust_analyser.enable = true;
      marksman.enable = true;
      pyright.enable = true;
      jsonls.enable = true;
      helm_ls.enable = true;
      yamlls = {
        enable = true;
        config = {
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
  plugins = {
    helm.enable = true;
    lspsaga.enable = true;
    lspconfig = {
      enable = true;
      settings = {
        folds.enabled = true;
        inlay_hints.enabled = true;
        diagnostics = {
          underline = true;
          update_in_insert = false;
          virtual_text = {
            spacing = 4;
            source = "if_many";
            prefix = "●";
          };
          severity_sort = true;
          signs = {
            text = {
              ERROR = "";
              WARN = "";
              HINT = "";
              INFO = "";
            };
          };
        };
      };
    };
  };

  keymaps = [
  ];

  extraConfigLua = ''
    Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
      if
        vim.api.nvim_buf_is_valid(buffer)
        and vim.bo[buffer].buftype == ""
      then
        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
      end
    end)

    Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
      if vim.opt.foldmethod == "expr" then
        vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
      end
    end)

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
}
