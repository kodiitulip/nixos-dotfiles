{
  appimageTools,
  fetchurl,
}:
let
  pname = "steam-art-manager";
  version = "v3.11.1";

  logo = fetchurl {
    url = "https://raw.githubusercontent.com/Tormak9970/Steam-Art-Manager/${version}/public/logo.png";
    hash = "sha256-g/Qg+fGr3ZP11JxWcEKfeQ+mr5R98v0yRw0FKu5WGww=";
  };

  src = fetchurl {
    url = "https://github.com/Tormak9970/Steam-Art-Manager/releases/download/${version}/steam-art-manager.AppImage";
    hash = "sha256-qBwYOhmwfMoTrwUGh+UCVzL/H2n5pKOYbvvoJ18PmWY=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -pv $out/share/icons/hicolor/512x512/apps
    cp -v ${logo} $out/share/icons/hicolor/512x512/apps/${pname}.png
    mkdir -pv $out/share/applications
    cat << EOF > $out/share/applications/${pname}.desktop
    [Desktop Entry]
    Comment=A tool for setting the artwork of your Steam library.
    Name=Steam Art Manager
    Exec=GTK_USE_PORTAL=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pname}
    Icon=${pname}
    Terminal=false
    Type=Application
    Categories=Utility
    StartupNotify=true
    EOF
  '';
}

