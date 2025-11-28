{ pkgs, config, ... }:

{
  xdg.configFile."lf/icons".source = ./lf-icons;

  programs.lf = {
    
    enable = true;

    commands = {
      z = ''
        %{{
          result="$(${pkgs.zoxide}/bin/zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
        }}
      '';
      zi = ''
        ''${{
          result="$(${pkgs.zoxide}/bin/zoxide query -i | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
        }}
      '';
      on-cd = ''
        &{{
          fmt="$(STARSHIP_SHELL= ${pkgs.starship}/bin/starship prompt | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id set promptfmt \"$fmt\""
          ${pkgs.zoxide}/bin/zoxide add "$PWD"
        }}
      '';
      dragon-out = ''%${pkgs.dragon-drop}/bin/dragon-drop -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
      trash = ''
        ''${{
          echo "Delete Files? [y/N]: "
          read ans
          [ $ans == 'y' ] && %${pkgs.trashy}/bin/trashy -- $fx || echo "Deleting canceled"
        }}
      '';
    };

    keybindings = {

      "\\\"" = "";
      o = "";
      c = "mkdir";
      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";

      do = "dragon-out";

      "g~" = "cd";
      gh = "cd";
      "g/" = "/";
      gd = "cd ~/Downloads";
      gp = "cd ~/Projects";

      ee = "editor-open";
      V = ''''$${pkgs.bat}/bin/bat "$f"'';

      d = "";
      dd = "delete";
      dD = "trash";

    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig =
      let 
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          #!/usr/bin/env sh
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in 
      ''
        set cleaner ${cleaner}/bin/clean.sh
      '';

    previewer = {
      keybinding = "i";
      source = pkgs.writeShellScript "pv.sh" ''
        #!/usr/bin/env sh

        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file" )" =~ ^image ]]; then
          ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
          exit 1
        fi

        ${pkgs.pistol}/bin/pistol "$file"
      '';
    };
  };
}