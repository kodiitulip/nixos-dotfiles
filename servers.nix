{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  environment.systemPackages = with pkgs; [ mcrcon ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/srv/minecraft-servers";

    servers.fossiled-steam = {
      enable = true;
      package = pkgs.neoforgeServers.neoforge-1_21_1;

      serverProperties = {
        server-port = 25565;
        online-mode = false;
        allow-flight = true;
        difficulty = "hard";
        motd = "Os Caba";
        rcon.port = 25575;
        enable-rcon = true;
        rcon.password = "fossil";
        simulation-distance = 8;
        view-distance = 12;
      };

      symlinks =
        let
          modpack = pkgs.fetchPackwizModpack {
            url = "https://github.com/blossom-garden/fossilized-steam/raw/refs/tags/2.0.0/pack.toml";
            packHash = "";
          };
        in
        {
          "mods" = "${modpack}/mods";
          "datapacks" = "${modpack}/datapacks";
          "resourcepacks" = "${modpack}/resourcepacks";
          "config" = "${modpack}/config";
          "defaultoptions" = "${modpack}/defaultoptions";
          "server-icon.png" = "${modpack}/icon.png";
        };
    };
  };

}
