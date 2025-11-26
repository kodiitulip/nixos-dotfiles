{ pkgs, config, ... }:

{
  programs.nushell = {
    enable = true;
    shellAliases = {
      btw = "echo I use NixOS, btw";
      vi = "nvim";

      gs = "git status";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push";
      gb = "git branch";
      gsw = "git switch";
      gd = "git diff";
      gcl = "git clone";

      e = "exit";
      c = "clear";
      lg = "lazygit";
      reload = "exec nu";
      gw = "./gradlew";
      cr = "cargo run";
      crq = "cr --quiet";
      cb = "cargo build";
      cbq = "cb --quiet";
      ct = "cargo test";
      ctq = "ct --quiet";
      ".." = "z ..";
      "..." = "z ../..";
      "3.." = "z ../../..";
      "4.." = "z ../../../..";
      "5.." = "z ../../../../";

      garbage-collect = "sudo nix-collect-garbage -d";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
    };

    environmentVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      RUSTC_WRAPPER = "sccache";
    };

    settings = {
      show_banner = false;
      buffer_editor = "nvim";
      use_kitty_protocol = true;
      edit_mode = "vi";
      cursor_shape = {
        vi_insert = "line";
        vi_normal = "blink_block";
      };
      completions.external = {
        enable = true;
        max_results = 200;
      };
      keybindings = [
        {
          name = "lfcd";
          modifier = "control";
          keycode = "char_o";
          mode = [ "emacs" "vi_normal" "vi_insert" ];
          event = {
            send = "executehostcommand";
            cmd = "lfcd";
          };
        }
      ];
    };

    envFile.text = ''
      def --env --wrapped lfcd [...args: string] { 
        cd (lf -print-last-dir ...$args)
      }
    '';

    extraConfig = ''
      $env.PATH ++= ['/home/kodie/.nuscripts/']

      def --env get-env [name] { $env | get $name }
      def --env set-env [name, value] { load-env { $name: $value } }
      def --env unset-env [name] { hide-env $name }

      def config-nix [--vscodium (-v)] {
        if $vscodium {
          cd ~/nixos-dotfiles/; codium .; cd -
        } else {
          cd ~/nixos-dotfiles/; nvim; cd -
        }
      }

      def bumpversion [] {
        print "use bumpversion packwiz <VERSION-STRING>"
      }

      def "bumpversion packwiz" [version: string] {
        if (not ('./pack.toml' | path exists)) {
          print "No pack.toml found"
          return
        }
        mv ./pack.toml ./pack.toml.bak
        cat ./pack.toml.bak | str replace -r 'version = "(.*)"' $'version = "($version)"' | save ./pack.toml
      }

      # mkdir ($nu.data-dir | path join "vendor/autoload")
      # tree-sitter complete --shell nushell | save -f ($nu.data-dir | path join "vendor/autoload/tree-sitter-completions.nu")

      # $env.TRANSIENT_PROMPT_COMMAND = ^starship prompt --profile transient
      # $env.TRANSIENT_PROMPT_INDICATOR = ""
      # $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ": "
      # $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
      # $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = "∙ "
      # $env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""

      source ~/.config/nushell/completions/lf.nu
      '';
  };
  xdg.configFile."nushell/completions" = {
    source = ./nushell/completions;
    recursive = true;
  };
}