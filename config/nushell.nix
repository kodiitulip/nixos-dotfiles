{ pkgs, lib, ... }:

{
  programs.nushell = {
    enable = true;
    shellAliases = {
      btw = ''print "I use NixOS, btw"'';
      vi = "nvim";
      vim = "nvim";

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

      julia-join = "sudo zerotier-cli join bb720a5aaedee869";
      julia-leave = "sudo zerotier-cli leave bb720a5aaedee869";

      ztls = "sudo zerotier-cli listnetworks";
    };

    environmentVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      SUDO_PROMPT = lib.hm.nushell.mkNushellInline "(^starship prompt --profile=sudo_prompt --terminal-width (term size).columns)";
      STARSHIP_LOG = "error";
      NU_EXPERIMENTAL_OPTIONS = "native-clip";
    };

    plugins = with pkgs.nushellPlugins; [
      semver
      query
      formats
    ];

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
          mode = [
            "emacs"
            "vi_normal"
            "vi_insert"
          ];
          event = {
            send = "executehostcommand";
            cmd = "lfcd";
          };
        }
      ];
    };

    extraConfig = ''
      $env.PATH = ($env.PATH | append '/home/kodie/.nuscripts' | append '/home/kodie/.bun/bin')

      def --env get-env [name] { $env | get $name }
      def --env set-env [name, value] { load-env { $name: $value } }
      def --env unset-env [name] { hide-env $name }

      # Edit NixOS Config
      def "config nix" [] {
        cd ~/nixos-dotfiles; nvim; cd -
      }

      def "bumpversion packwiz" [version: string] {
        if (not ('./pack.toml' | path exists)) {
          print "No pack.toml found"
          return
        }
        cat ./pack.toml | str replace -r 'version = "(.*)"' $'version = "($version)"' | save -f ./pack.toml
      }

      export-env { load-env {
        PROMPT_MULTILINE_INDICATOR: (^starship prompt --continuation)
        TRANSIENT_PROMPT_MULTILINE_INDICATOR: (^starship prompt --continuation)

        TRANSIENT_PROMPT_INDICATOR: ""

        TRANSIENT_PROMPT_COMMAND: {||
          (
            let cmd_duration = if $env.CMD_DURATION_MS == "0823" { 0 } else { $env.CMD_DURATION_MS };
            ^starship prompt
              --profile=transient
              --cmd-duration $cmd_duration
              $"--status=($env.LAST_EXIT_CODE)"
              --terminal-width (term size).columns
              --jobs (job list | length)
          )
        }
      }}

      set-env ACTIVE_OVERLAYS []

      def load-overlays [dir: string] {
        let overlay_file = ($dir | path join ".nu-overlay")
        if not ($overlay_file | path exists) {
          return
        }

        let modules = (open $overlay_file
        | lines
        | where {|l| ($l | str trim) != "" and not ($l | str starts-with "#") })
        
        if ((get-env ACTIVE_OVERLAYS) == ($modules | each {|m|
          (($dir | path join $m) | path parse | get stem)
        })) { return }

        set-env ACTIVE_OVERLAYS ($modules | each {|m|
          let module_path = ($dir | path join $m)
          let overlay_name = ($module_path | path parse | get stem)
          if ($module_path | path exists) {
            overlay use --prefix $module_path
            $overlay_name
          } else {
            print $"Warning: ($module_path) not found"
            null
          }
        })
      }

      def unload-overlays [] {
        if ((get-env ACTIVE_OVERLAYS) | is-empty) { return }
        set-env ACTIVE_OVERLAYS ((get-env ACTIVE_OVERLAYS) | each {|o|
          overlay hide $o
        })
      }

      $env.config = ($env.config | upsert hooks.env_change.PWD [
        {
          code: {|before, after|
            let has_new = (($after | path join ".nu-overlay") | path exists)
            unload-overlays
            if $has_new { load-overlays $after }
          }
        }
      ])
    '';
  };
}
