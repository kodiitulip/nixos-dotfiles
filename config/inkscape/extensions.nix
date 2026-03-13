{
  lib,
  stdenv,
  fetchFromGitHub,
}:
{
  godot-tools = stdenv.mkDerivation {
    pname = "godot-tools";
    version = "1.0.0";

    src = fetchFromGitHub {
      owner = "OS-of-S";
      repo = "Inkscape-Tools-for-Godot-Editor-Designing";
      rev = "main";
      hash = "sha256-pC0L2cad1YaYcqXea3MQ5OS9pejk/MyAe1c18j0iDdM=";
    };

    preferLocalBuild = true;

    installPhase = ''
      runHook preInstall

      ls -la
      mkdir -p "$out/share/inkscape/extensions/icons/"
      cp -pv **/*.inx **/*.py "$out/share/inkscape/extensions/"
      ls -la "$out/share/inkscape/extensions/"
      ls -la "$out/share/inkscape/extensions/icons"
      cp -pv **/**/*.svg "$out/share/inkscape/extensions/icons/"
      find "$out/share/inkscape/extensions/" -name "*.py" -exec chmod +x {} \;

      runHook postInstall
    '';

    meta = {
      description = "This is an extension for helping with creating icons for the Godot Engine";
      homepage = "https://github.com/OS-of-S/Inkscape-Tools-for-Godot-Editor-Designing";
      license = lib.licenses.mit;
      maintainers = [ ];
      platforms = lib.platforms.all;
    };
  };
}
