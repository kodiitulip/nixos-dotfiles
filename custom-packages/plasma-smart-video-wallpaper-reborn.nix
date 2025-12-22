{
  extra-cmake-modules,
  fetchFromGitHub,
  kpackage,
  libplasma,
  lib,
  mkKdeDerivation,
  pkg-config,
  qtbase,
  qtmultimedia,
}:
let
  version = "v2.8.0";
  hash = "sha256-NnmcanyjPDhR1QvVZiwFkNOarUeGaGTqaEkQZb8G7pQ="; # lib.fakeHash;
in
mkKdeDerivation {
  inherit version;
  pname = "plasma-smart-video-wallpaper-reborn";

  src = fetchFromGitHub {
    inherit hash;
    owner = "luisbocanegra";
    repo = "plasma-smart-video-wallpaper-reborn";
    rev = version;
  };

  extraNativeBuildInputs = [
    kpackage
    pkg-config
  ];

  runtimeLibs = lib.makeLibraryPath [
    qtmultimedia
  ];

  extraBuildInputs = [
    extra-cmake-modules
    libplasma
  ];

  extraCmakeFlags = [
    (lib.cmakeFeature "QML_LIB" (
      lib.makeSearchPathOutput "out" "lib/qt-6/qml" [
        qtmultimedia
      ]
    ))
    (lib.cmakeFeature "Qt6_DIR" "${qtbase}/lib/cmake/Qt6")
  ];

  meta = {
    description = "Plasma 6 Wallpaper plugin to play videos on your Desktop/Lock Screen";
    homepage = "https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn";
    license = lib.licenses.gpl2Only;
  };
}
