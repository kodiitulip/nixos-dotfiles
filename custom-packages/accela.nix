{
  lib,
  stdenv,
  fetchurl,
  makeDesktopItem,
  copyDesktopItems,
  python,
  numpy,
  pyqt6-sip,
  pyqt6,
  psutil,
  beautifulsoup4,
  steam,
  requests,
  configobj,
  pathlib2,
  playsound,
  pyinstaller,
  cryptography,
  pillow,
  zstandard,
  pygame,
  pyyaml,
  gnutar,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "accela";
  src = fetchurl {
    url = "https://files.catbox.moe/tccrq8.gz";
    hash = lib.fakeHash;
    postFetch = ''"${lib.getExe gnutar}" -xzf $downloadedFile -C $out '';
  };

  nativeBuildInputs = [
    copyDesktopItems
  ];

  buildInputs = [
    python
    pyqt6-sip
    pyqt6
    psutil
    beautifulsoup4
    steam
    requests
    configobj
    pathlib2
    playsound
    pyinstaller
    cryptography
    pillow
    numpy
    zstandard
    pygame
    pyyaml
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/accela $out/bin
    mv ./run.sh ./accela
    mv ./requirements.txt ./requirements.txt.old
    chmod +x ./accela
    chmod +x ./src/deps/DepotDownloaderMod 2>/dev/null || true
    cp -rpf * $out/share/accela
    cp ./accela.png $out/share/icons/hicolor/512x512/apps
    ln -s $out/share/accela/accela $out/bin

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "accela";
      desktopName = "ACCELA";
      exec = "accela";
      icon = "accela";
      comment = "ＧｏＤ_Ｉｓ_ｉＮ_ｔＨｅ_ＷｉＲｅＤ";
      type = "Application";
      categories = [
        "Utility"
        "Application"
      ];
    })
  ];

  meta = {
    description = "Welcome to the Wired.";
    platforms = lib.platforms.linux;
    mainProgram = "accela";
  };
})
