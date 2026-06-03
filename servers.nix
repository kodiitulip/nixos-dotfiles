{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  environment.systemPackages = with pkgs; [ tmux ];

  services.minecraft-servers =
    let
      thems-the-rules = pkgs.fetchPackwizModpack {
        url = "https://github.com/blossom-garden/thems-the-rules/raw/refs/tags/1.1.0/pack.toml";
        packHash = "";
      };
    in
    {
      enable = true;
      eula = true;
      openFirewall = true;
      dataDir = "/srv/minecraft-servers";
      managementSystem.tmux.enable = true;

      servers = {
        thems-the-rules = {
          enable = true;
          autoStart = false;
          package = pkgs.neoforgeServers.neoforge-1_21_1-21_1_230;

          serverProperties = {
            server-port = 35565;
            online-mode = false;
            allow-flight = true;
            difficulty = "hard";
            motd = "LexoSesbico";
            simulation-distance = 8;
            view-distance = 10;
          };
          jvmOpts = "-Xms2G -Xmx4G";

          symlinks = {
            "mods" = "${thems-the-rules}/mods";
            "datapacks" = "${thems-the-rules}/datapacks";
            "resourcepacks" = "${thems-the-rules}/resourcepacks";
            "server-icon.png" = "${thems-the-rules}/server-icon.png";
          };
          files = {
            "config" = "${thems-the-rules}/config";
          };
        };
      };
    };

}
