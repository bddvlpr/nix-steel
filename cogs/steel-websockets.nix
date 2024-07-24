{
  buildSteelCog,
  rustPlatform,
  steel,
}: let
  name = "steel-websockets";
  version = "0.1.0";

  core = rustPlatform.buildRustPackage {
    name = "${name}-core";
    inherit version;

    src = steel.src;

    cargoBuildFlags = "-p steel-websockets";
    cargoLock = {
      lockFile = "${steel.src}/Cargo.lock";
      outputHashes = {
        "lasso-0.7.2" = "sha256-ccqcDvWZD5hp4iZ420jgNJtR+MaVlqHFtXU2GWkbyfg=";
      };
    };

    doCheck = false;
  };
in
  buildSteelCog {
    inherit name version;

    buildPhase = ''
      cp -r $src $out

      cp -r ${core} $out
    '';

    dylib = true;
  }
