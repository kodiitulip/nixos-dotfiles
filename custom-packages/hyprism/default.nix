{
  appimageTools,
  fetchurl,
}:

let
  pname = "hyprism";
  version = "3.0.1";

  src = fetchurl {
    url = "https://github.com/HyPrismTeam/HyPrism/releases/download/v${version}/HyPrism-linux-x86_64-${version}.AppImage";
    hash = "sha256-vb93cI9ABNJqrhe09JB0oTz5dCe9cPfPj/U3Ps/Ud+s=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs =
    pkgs: with pkgs; [
      icu
      openssl
      zlib
      libunwind
      libuuid
      stdenv.cc.cc
      libGL
      libx11
      libxcursor
      libxrandr
      libxext
      libxi
      libxkbcommon
    ];

  extraWrapperArgs = [
    "--add-flags"
    "--ozone-platform-hint=auto"
    "--add-flags"
    "--enable-features=WaylandWindowDecorations"
  ];

  extraInstallCommands = ''
    mkdir -pv $out/share/applications $out/share/icons/hicolor/256x256/apps

    install -m 444 ${appimageContents}/HyPrism.desktop \
      $out/share/applications/${pname}.desktop
    install -m 444 ${appimageContents}/HyPrism.png \
      $out/share/icons/hicolor/256x256/apps/${pname}.png

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}' \
      --replace-fail 'Icon=HyPrism' 'Icon=${pname}'
  '';

  meta = {
    description = "Hytale launcher with mod management";
    homepage = "https://github.com/HyPrismTeam/HyPrism";
    platforms = [ "x86_64-linux" ];
  };
}
