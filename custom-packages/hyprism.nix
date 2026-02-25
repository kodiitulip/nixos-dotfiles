{
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub,
}:
buildDotnetModule rec {
  pname = "hyprism";
  version = "3.0.1";

  src = fetchFromGitHub {
    owner = "HyPrismTeam";
    repo = "HyPrism";
    tag = "v${version}";
    hash = "sha256-5HSbukaGs8ipALBZ0QCw3hf9ml0uyL83v60zBMCsSh4=";
  };

  projectFile = "HyPrism.csproj";

  dotnet-sdk = dotnetCorePackages.sdk_10_0-bin;
  dotnet-runtime = dotnetCorePackages.runtime_10_0-bin;

  executables = [ "HyPrism" ];

  meta = {
    description = "Hytale launcher with mod management, and more!";
    mainProgram = "hyprism";
    homepage = "https://hyprismteam.github.io/hyprism-site";
    maintainers = [ ];
  };
}
