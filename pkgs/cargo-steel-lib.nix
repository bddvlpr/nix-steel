{
  lib,
  rustPlatform,
  src,
}:
rustPlatform.buildRustPackage rec {
  name = "cargo-steel-lib";
  version = "0-unstable-2024-07-22";

  inherit src;

  cargoBuildFlags = "-p cargo-steel-lib";
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "lasso-0.7.2" = "sha256-ccqcDvWZD5hp4iZ420jgNJtR+MaVlqHFtXU2GWkbyfg=";
    };
  };

  doCheck = false;

  meta = with lib; {
    description = "Cargo plugin to help with bootstrapping Steel";
    repository = "https://github.com/mattwparas/steel";
    license = with licenses; [mit asl20];
    mainProgram = "cargo-steel-lib";
    maintainers = with maintainers; [bddvlpr];
  };
}
