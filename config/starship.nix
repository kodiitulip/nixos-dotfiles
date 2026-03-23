{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      command_timeout = 1000;
      format = lib.concatStrings [
        "$sudo"
        "$username"
        "$directory"
        "$git_branch"
        "$git_status"
        "$fill"
        "$bun"
        "$c"
        "$elixir"
        "$elm"
        "$golang"
        "$haskell"
        "$java"
        "$julia"
        "$nodejs"
        "$nim"
        "$rust"
        "$scala"
        "$conda"
        "$python"
        "$direnv"
        "$time\n "
        "$character"
      ];
      palettes.rose-pine = {
        foam = "#9ccfd8";
        gold = "#f6c177";
        iris = "#c4a7e7";
        love = "#eb6f92";
        overlay = "#26233a";
        pine = "#31748f";
        rose = "#ebbcba";
      };
      palette = "rose-pine";
      profiles.transient = lib.concatStrings [
        "[](fg:overlay)[ 󰧱 ](bg:overlay fg:iris)[](fg:overlay) "
        "$fill "
        "[](fg:overlay)[ 󰴈 ](bg:overlay fg:rose)[](fg:overlay) "
        "$time\n "
        "$character"
      ];
      profiles.sudo_prompt = lib.concatStrings [
        "[](fg:overlay)[  ](bg:overlay fg:iris)[](fg:overlay) "
        "[](fg:iris) "
      ];
      character = {
        format = "[󱞪](fg:iris) ";
        success_symbol = "[󱞪](bold fg:green)";
        error_symbol = "[󱞪](bold fg:red)";
        vimcmd_symbol = "[󱞦](bold fg:green)";
        vimcmd_replace_one_symbol = "[󱞦](bold fg:lavender)";
        vimcmd_replace_symbol = "[󱞦](bold fg:lavender)";
        vimcmd_visual_symbol = "[󱞦](bold fg:yellow)";
      };
      fill = {
        style = "fg:overlay";
        symbol = "=";
      };
      username = {
        disabled = false;
        format = "[](fg:overlay)[ 󰧱 $user ]($style)[](fg:overlay) ";
        show_always = true;
        style_root = "bg:overlay fg:love";
        style_user = "bg:overlay fg:iris";
      };
      sudo = {
        disabled = false;
        format = "[](fg:overlay)[ $symbol ]($style)[](fg:overlay) ";
        style = "bg:overlay fg:love";
        symbol = "";
      };
      directory = {
        format = "[](fg:overlay)[ $path ]($style)[](fg:overlay) ";
        style = "bg:overlay fg:pine";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Blender = "  ";
          Documents = " 󰈙 ";
          Downloads = "  ";
          Godot = "  ";
          Java = "  ";
          Minecraft = " 󰍳 ";
          Music = "  ";
          Pictures = "  ";
          Projects = "  ";
          Python = "  ";
          Rust = "  ";
          Web = "  ";
          Streaming = " 󰄄 ";
        };
      };
      time = {
        disabled = false;
        format = " [](fg:overlay)[ $time 󰴈 ]($style)[](fg:overlay)";
        style = "bg:overlay fg:rose";
        time_format = "%R";
      };
      direnv = {
        disabled = false;
        format = " [](fg:overlay)[$symbol ($allowed $loaded) ]($style)[](fg:overlay)";
        symbol = "  ";
        style = "bg:overlay fg:pine";
        allowed_msg = "󰄬";
        not_allowed_msg = "";
        denied_msg = "";
        loaded_msg = "";
        unloaded_msg = "";
      };
    };
  };
}
