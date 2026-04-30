{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  environment.systemPackages = with pkgs; [ tmux ];

  services.minecraft-servers = {
    enable = false;
    eula = true;
    openFirewall = true;
    dataDir = "/srv/minecraft-servers";

    servers.fossil = {
      enable = false;
      package = pkgs.fabricServers.fabric-1_20_1;

      serverProperties = {
        server-port = 25565;
        online-mode = false;
        allow-flight = true;
        difficulty = "hard";
        motd = "Os Caba";
        simulation-distance = 8;
        view-distance = 12;
      };

      jvmOpts = "-Xmx4G";

      # symlinks =
      #   let
      #     modpack = pkgs.fetchPackwizModpack {
      #       url = "https://github.com/blossom-garden/fossilized-steam/raw/refs/tags/2.0.0/pack.toml";
      #       packHash = "sha256-g4reFJfyT9S8q72bDk7lqnIxzs9r84HiNxjyyhljpMk=";
      #     };
      #   in
      #   {
      #     "mods" = "${modpack}/mods";
      #     "datapacks" = "${modpack}/datapacks";
      #     "resourcepacks" = "${modpack}/resourcepacks";
      #     "config" = "${modpack}/config";
      #     "defaultoptions" = "${modpack}/defaultoptions";
      #     "server-icon.png" = "${modpack}/icon.png";
      #   };
    };
  };

}
