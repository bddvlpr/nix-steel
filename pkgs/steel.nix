{
  lib,
  rustPlatform,
  src,
  cargo-steel-lib,
}:
rustPlatform.buildRustPackage rec {
  name = "steel";
  version = "0-unstable-2024-07-22";

  inherit src;

  cargoBuildFlags = "-p steel-interpreter";
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "lasso-0.7.2" = "sha256-ccqcDvWZD5hp4iZ420jgNJtR+MaVlqHFtXU2GWkbyfg=";
    };
  };

  postInstall = ''
    mkdir -p $out/{cogs,home}

    # TODO: This will most likely be replaced with a 'buildSteelHome' function to allow passing cogs and their version(s).
    substituteInPlace cogs/installer/download.scm --replace-warn "cargo-steel-lib" "${lib.getExe cargo-steel-lib}"
    cp -r cogs $out

    export STEEL_HOME=$out/home
    pushd cogs
    $out/bin/steel install.scm
    popd
  '';

  doCheck = false;

  meta = with lib; {
    description = "An embedded scheme interpreter in Rust";
    repository = "https://github.com/mattwparas/steel";
    license = with licenses; [mit asl20];
    mainProgram = "steel";
    maintainers = with maintainers; [bddvlpr];
  };
}
