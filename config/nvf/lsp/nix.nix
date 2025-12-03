{ pkgs, lib, ... }:

{
  vim = {
    languages.nix = {
      enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
      format.type = "nixfmt";
      lsp.enable = true;
      treesitter.enable = true;
    };

    utility.direnv.enable = true;

    statusline.lualine.activeSection.x = [
      ''
        {
          function()
            return require("direnv").statusline()
          end
        }
      ''
      ''
        {
          -- Lsp server name
          function()
            local buf_ft = vim.bo.filetype
            local excluded_buf_ft = {
              toggleterm = true,
              NvimTree = true,
              ["neo-tree"] = true,
              TelescopePrompt = true,
              ["snacks_picker_list"] = true,
            }

            if excluded_buf_ft[buf_ft] then
              return ""
              end

            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients({ bufnr = bufnr })

            if vim.tbl_isempty(clients) then
              return "No Active LSP"
            end

            local active_clients = {}
            for _, client in ipairs(clients) do
              table.insert(active_clients, client.name)
            end

            return table.concat(active_clients, ", ")
          end,
          icon = ' ',
          separator = {left = ''},
        }
      ''
      ''
        {
          "diagnostics",
          sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
          symbols = {error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 '},
          colored = true,
          update_in_insert = false,
          always_visible = false,
          diagnostics_color = {
            color_error = { fg = 'red' },
            color_warn = { fg = 'yellow' },
            color_info = { fg = 'cyan' },
          },
        }
      ''
    ];

    keymaps = [
      {
        key = "<leader>De";
        action = ''function() require("direnv").allow_direnv() end'';
        mode = "n";
        lua = true;
      }
      {
        key = "<leader>Dr";
        action = ''function() require("direnv").check_direnv() end'';
        mode = "n";
        lua = true;
      }
    ];
  };
}

