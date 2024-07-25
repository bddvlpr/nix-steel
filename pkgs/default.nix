{pkgs, ...}: let
  src = pkgs.fetchFromGitHub {
    owner = "mattwparas";
    repo = "steel";
    rev = "1eb4d9b4242cae9627466d73ddf681a39443357a";
    hash = "sha256-35ZepMM0d/EsbiQ1/7x2DicybeXfZI5O37l6Okzc4Xk=";
  };
in rec {
  cargo-steel-lib = pkgs.callPackage ./cargo-steel-lib.nix {inherit src;};
  steel = pkgs.callPackage ./steel.nix {inherit src cargo-steel-lib;};
  steel-language-server = pkgs.callPackage ./steel-language-server.nix {inherit src;};

  default = steel;
}
