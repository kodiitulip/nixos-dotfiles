{
  lib,
  stdenv,
  fetchFromGitHub,
  godot,
  godot-export-templates-bin,
  nix-update-script,
  libglvnd,
  libXinerama,
  libXcursor,
  libXext,
  libXrandr,
  libXrender,
  libX11,
  libXi,
  libXfixes,
}:

let
  export_preset = "Linux/X11";
in
stdenv.mkDerivation (finalAttrs: {
  pname = "pngtube-remix";
  version = "V1.4(Patch2)";

  src = fetchFromGitHub {
    owner = "MudkipWorld";
    repo = "PNGTuber-Remix";
    rev = "${finalAttrs.version}";
    hash = "sha256-2E+B8/eM1I2g1sqwA50rxUvqNw/aehYJaNVmPahHqXA=";
  };

  nativeBuildInputs = [ godot ];

  buildInputs = [
    libglvnd
    libXinerama
    libXcursor
    libXext
    libXrandr
    libXrender
    libX11
    libXi
    libXfixes
  ];

  preConfigure = ''
    godot_ver="${lib.versions.majorMinor godot.version}"
    godot_expected=$(sed -n -E 's@config/features=PackedStringArray\("([0-9]+\.[0-9]+)"\)@\1@p' project.godot)
    [ "$godot_ver" == "$godot_expected" ] || {
      echo "Expected Godot version: $godot_expected; found: $godot_ver" >&2
      exit 1
    }
  '';

  buildPhase = ''
    runHook preBuild

    export HOME=$TMPDIR
    mkdir -vp $HOME/.local/share/godot
    ln -s "${godot-export-templates-bin}"/share/godot/export_templates "$HOME"/.local/share/godot

    mkdir -vp build
    godot -v --headless --editor --quit --import ${finalAttrs.src}/project.godot
    godot -v --headless --export-release "${export_preset}" build/pngtube-remix

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -D -m 755 -t $out/libexec ./build/pngtube-remix
    install -D -m 644 -t $out/libexec ./build/pngtube-remix.pck

    cat << EOF > ./build/pngtube-remix.desktop
    [Desktop Entry]
    Name=PNGTube-Remix
    GenericName=2D PNG Tuber tool
    Comment=A PNGTube (PuppeTube/ PaperDoll-Tube) software made using Godot!
    Exec=pngtube-remix %u
    Icon=pngtube-remix
    StartupWMClass=PNGTube-Remix
    Terminal=false
    Type=Application
    Categories=Graphics;2DGraphics;RasterGraphics;Multimedia;
    Keywords=png;animation;art;image;2d;sprite;graphics;streaming;editor;
    MimeType=image/png;image/jpeg;image/svg+xml;image/psd;application/x-pngremix;application/x-save;
    EOF

    install -D -m 644 -t $out/share/applications ./build/pngtube-remix.desktop
    install -D -m 644 -T ./PicklesSurprised.png $out/share/icons/hicolor/256x256/apps/pngtube-remix.png
    install -d -m 755 $out/bin
    ln -s $out/libexec/pngtube-remix $out/bin/pngtube-remix

    runHook postInstall
  '';

  fixupPhase = ''
    runHook preFixup

    patchelf \
      --set-interpreter '${stdenv.cc.bintools.dynamicLinker}' \
      --set-rpath ${lib.makeLibraryPath finalAttrs.buildInputs} \
      $out/libexec/pngtube-remix

    runHook postFixup
  '';

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    homepage = "https://mudkipworld.itch.io/pngtube-remix";
    description = "A PNGTube (PuppeTube/ PaperDoll-Tube) software made using Godot!";
    changelog = "https://github.com/MudkipWorld/PNGTuber-Remix/releases/tag/${finalAttrs.src.rev}";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
    mainProgram = "pngtube-remix";
  };
})