
{ pkgs, config, ... }:

{
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;

    keymap = {
      mgr = {
        prepend_keymap = [
          # { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Chmod on selected files" }
          # { on = [ "c" "a" ]; run = "plugin compress"; desc = "Archive selected files" }
          # { on = [ "g" "i" ]; run = "plugin lazygit"; desc = "run lazygit" }
          # { on = "<C-y>"; run = "plugin wl-clipboard" }
          # { on = "M"; run = "plugin mount" }
          # { on = "l"; run = "plugin smart-enter"; desc = "Enter the child directory; or open the file" }
          # { on = "<Right>"; run = "plugin smart-enter"; desc = "Enter the child directory; or open the file" }
          # { on = "F"; run = "plugin smart-filter"; desc = "Smart Filter" }
          # { on = "<C-n>"; run = 'shell -- dragon -x -i -T "$1"' }
          # { on = "y"; run = [ ''shell -- for path in "$0"; do echo "file://$path"; done | wl-copy -t text/uri-list'' "yank" ] }
          { on = "!"; run = ''shell "$SHELL" --block''; desc = "Open shell here"; }
          { on = [ "g" "r" ]; run = ''shell -- ya emit cd "$(git rev-parse --show-toplevel)"''; }
        ];
      };
    };
  };
}