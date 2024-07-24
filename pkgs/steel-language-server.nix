{
  lib,
  rustPlatform,
  src,
}:
rustPlatform.buildRustPackage rec {
  name = "steel-language-server";
  version = "0-unstable-2024-07-22";

  inherit src;

  cargoBuildFlags = "-p steel-language-server";
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "lasso-0.7.2" = "sha256-ccqcDvWZD5hp4iZ420jgNJtR+MaVlqHFtXU2GWkbyfg=";
    };
  };

  doCheck = false;

  meta = with lib; {
    description = "A language server for Steel";
    license = with licenses; [mit asl20];
    mainProgram = "steel-language-server";
    maintainers = with maintainers; [bddvlpr];
  };
}
