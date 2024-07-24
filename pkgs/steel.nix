{
  lib,
  rustPlatform,
  src,
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

  postBuild = ''
    mkdir -p $out/cogs
    cp -r cogs $out
  '';

  doCheck = false;

  meta = with lib; {
    description = "An embedded scheme interpreter in Rust";
    license = with licenses; [mit asl20];
    mainProgram = "steel";
    maintainers = with maintainers; [bddvlpr];
  };
}
