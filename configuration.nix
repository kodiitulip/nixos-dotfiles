{
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs = {
    overlays = [
      inputs.vintagestory-nix.overlays.default
      (final: prev: {
        mrpack-install = prev.mrpack-install.overrideAttrs (old: rec {
          version = "0.21.0-beta";
          src = prev.fetchFromGitHub {
            owner = "nothub";
            repo = "mrpack-install";
            tag = "v${version}";
            hash = "sha256-QSgq9VgiEg2aZLgMhzhFE2IpSVcYdmmRV9CJWkWPkg4=";
          };
          vendorHash = "sha256-ZbQICz2z2+SPY1z9dS5AXJh18+522PfT/wPg5GhmNZQ=";
          checkFlags =
            let
              skippedTests = [
                # Skip tests that require network access
                "TestFetchMetadata"
                "TestClient_VersionFromHash"
                "TestClient_GetDependencies"
                "TestClient_GetProjectVersions_Count"
                "TestClient_GetVersion"
                "TestClient_CheckProjectValidity_Slug"
                "Test_GetProject_404"
                "TestClient_GetProjects_Count"
                "TestClient_GetProjectVersions_Filter_NoResults"
                "Test_GetProject_Success"
                "TestClient_CheckProjectValidity_Id"
                "TestClient_GetLatestGameVersion"
                "TestClient_GetProjectVersions_Filter_Results"
                "TestClient_GetProjects_Slug"
                "TestClient_GetVersions"
                "TestGetPlayerUuid"
                "TestClient_VersionFromMrpackFile"
              ];
            in
            [ "-skip=^${builtins.concatStringsSep "$|^" skippedTests}$" ];
          postInstall = "";
        });
      })
    ];

    config.allowUnfree = true;
  };

  imports = [
    inputs.nixvim.nixosModules.nixvim
    inputs.playit-nixos-module.nixosModules.default
    inputs.agenix.nixosModules.default
    ./servers.nix
    ./hardware-configuration.nix
    ./system-services.nix
    ./system-programs.nix
    ./system-packages.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };

  security.polkit.enable = true;

  time.timeZone = "America/Fortaleza";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  xdg.icons.fallbackCursorThemes = [ "BreezeX-RosePine-Linux" ];
  console.keyMap = "br-abnt2";
  security.rtkit.enable = true;

  users.users = {
    kodie = {
      isNormalUser = true;
      description = "Kodie Sales";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = [ ];
      shell = pkgs.nushell;
    };
  };

  users.groups.copyparty = { };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  hardware = {
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking = {
    hosts = {
      "172.24.145.167" = [ "julia-servers" ];
    };
    hostName = "nixos";
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        3000
        6567
        42420
        25565
      ];
      allowedUDPPorts = [
        6567
        42420
        25565
      ];
    };
  };
  virtualisation.docker.enable = true;

  system.stateVersion = "25.05"; # WARN: DO NOT CHANGE! NO NEED TO!
}
