_: {
  plugins.snacks = {
    enable = true;

    settings = {
      bigfile.enabled = true;
      indent.enabled = true;
      input.enabled = true;
      explorer.enabled = true;
      notifier.enabled = true;
      picker = {
        win.input.keys.__raw = ''
          {
            ["<a-s>"] = {
              "flash",
              mode = { "n", "i" },
            },
            ["s"] = { "flash" },
          }
        '';
        actions.flash.__raw = ''
          function(picker)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end
        '';
        sources = {
          gh_issue = { };
          gh_pr = { };

        };
      };
      scope.enabled = true;
      scroll.enabled = true;
      words.enabled = true;
      terminal.win.style = "floating_terminal";
      gh = { };
      styles = {
        floating_terminal = {
          style = "terminal";
          position = "float";
          border = "rounded";
        };
        lazygit = {
          position = "float";
          border = "rounded";
        };
      };
      lazygit = {
        configure = true;
        config = { };
        theme_path.__raw = ''svim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml")'';
        theme = {
          __rawKey__241.fg = "Special";
          cherryPickedCommitBgColor.fg = "Identifier";
          cherryPickedCommitFgColor.fg = "Function";
          defaultFgColor.fg = "Normal";
          inactiveBorderColor.fg = "FloatBorder";
          optionsTextColor.fg = "Function";
          selectedLineBgColor.bg = "Visual";
          unstagedChangesColor.fg = "DiagnosticError";
          activeBorderColor = {
            fg = "MatchParen";
            bold = true;
          };
          searchingActiveBorderColor = {
            fg = "MatchParen";
            bold = true;
          };
        };
        win.style = "lazygit";
      };
      dashboard = {
        preset = {
          header = ''
             ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
             ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
            ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
            ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
            ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
            ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
            ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
               ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
                     ░    ░  ░    ░ ░        ░   ░         ░   
                                            ░                  
          '';
          keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.dashboard.pick('files')";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              icon = " ";
              key = "g";
              desc = "Find Text";
              action = ":lua Snacks.dashboard.pick('live_grep')";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
            {
              icon = " ";
              key = "c";
              desc = "Config";
              action = ":lua Snacks.dashboard.pick('files'; {cwd = '/home/kodie/nixos-dotfiles'})";
            }
            {
              icon = " ";
              key = "s";
              desc = "Restore Session";
              section = "session";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
        };
        sections = [
          { section = "header"; }
          {
            section = "keys";
            gap = 1;
            padding = 1;
          }
        ];
      };
    };
  };
  keymaps = [
    {
      key = "<leader>e";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.explorer()<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Snacks Explorer";
      };
    }
    {
      key = "<leader>sK";
      mode = [ "n" ];
      action.__raw = ''function() Snacks.picker('keymaps') end'';
      options = {
        silent = true;
        noremap = true;
        desc = "Snacks Explorer";
      };
    }
    {
      key = "<leader>/";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.grep()<CR>";
      options = {
        silent = true;
        noremap = true;
      };
    }

    # Terminal

    {
      mode = [ "n" ];
      key = "<leader>ft";
      action.__raw = ''function() Snacks.terminal() end'';
      options = {
        desc = "Terminal (cwd)";
      };
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<c-/>";
      action.__raw = ''function() Snacks.terminal() end'';
      options = {
        desc = "Terminal (Root Dir)";
      };
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<c-_>";
      action.__raw = ''function() Snacks.terminal() end'';
      options = {
        desc = "which_key_ignore";
      };
    }

    {
      key = "<leader>n";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.notifications()<CR>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>fb";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.buffers()<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Buffer Picker";
      };
    }
    {
      key = "<leader><space>";
      mode = [ "n" ];
      action.__raw = "function() Snacks.picker.smart() end";
      options = {
        silent = true;
        noremap = true;
        desc = "Smart Pick Files";
      };
    }
    {
      key = "<leader>gl";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.git_log()<CR>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>gb";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.git_branches()<CR>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>gB";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.gitbrowse()<CR>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>gg";
      mode = [ "n" ];
      action.__raw = ''function() Snacks.lazygit() end'';
      options = {
        silent = true;
        noremap = true;
        desc = "Lazygit";
      };
    }
    {
      key = "<leader>gs";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.git_status()<CR>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      key = "<leader>uC";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.colorschemes()<CR>";
    }
    {
      key = "<leader>:";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.command_history()<CR>";
    }
    {
      key = "<leader>st";
      action.__raw = ''function() Snacks.picker.todo_comments() end'';
      options.desc = "Todo";
    }
    {
      key = "<leader>sT";
      action.__raw = ''function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end'';
      options.desc = "Todo/Fix/Fixme";
    }
  ];
}
