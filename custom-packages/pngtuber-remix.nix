{
  lib,
  fetchFromGitHub,
  godot,
  godot-export-templates-bin,
  libglvnd,
  libX11,
  libXcursor,
  libXext,
  libXfixes,
  libXi,
  libXinerama,
  libXrandr,
  libXrender,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "pngtuber-remix";
  version = "nightly";

  src = fetchFromGitHub {
    owner = "MudkipWorld";
    repo = "PNGTuber-Remix";

  };
})
