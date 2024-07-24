{
  lib,
  stdenvNoCC,
  steel,
}:
stdenvNoCC.mkDerivation {
  name = "steel-home";

  dontUnpack = true;

  buildPhase = ''
    mkdir -p $out

    export STEEL_HOME=$out

    ${lib.getExe steel} ${steel}/cogs/install.scm
  '';
}
