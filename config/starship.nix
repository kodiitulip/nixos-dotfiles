{
  enable = true;
  settings = {
    add_newline = true;
    command_timeout = 1000;
    format = "$sudo$username$directory$git_branch$git_status$fill$bun$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$scala$conda$python$time\n $character";
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
    profiles.transient = "[](fg:overlay)[ 󰧱 ](bg:overlay fg:iris)[](fg:overlay) $fill [](fg:overlay)[ 󰴈 ](bg:overlay fg:rose)[](fg:overlay)\n $character";
    character.format = "[󱞪](fg:iris) ";
    fill = {
      style = "fg:overlay";
      symbol = "=";
    };
    username = {
      disabled = false;
      format = "[](fg:overlay)[ 󰧱 $user ]($style)[](fg:overlay) ";
      show_always = true;
      style_root = "bg:overlay fg:iris";
      style_user = "bg:overlay fg:iris";
    };
    sudo = {
      disabled = false;
      format = "[](fg:overlay)[ $symbol ]($style)[](fg:overlay) ";
      style = "bg:overlay fg:iris";
      symbol = "󰧱";
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
      };
    };
    time = {
      disabled = false;
      format = " [](fg:overlay)[ $time 󰴈 ]($style)[](fg:overlay)";
      style = "bg:overlay fg:rose";
      time_format = "%I:%M%P";
      use_12hr = false;
    };
  };
}
