{pkgs, ...}: let
  src = pkgs.fetchFromGitHub {
    owner = "mattwparas";
    repo = "steel";
    rev = "1eb4d9b4242cae9627466d73ddf681a39443357a";
    hash = "sha256-35ZepMM0d/EsbiQ1/7x2DicybeXfZI5O37l6Okzc4Xk=";
  };
in rec {
  steel = pkgs.callPackage ./steel.nix {inherit src;};
  steel-language-server = pkgs.callPackage ./steel-language-server.nix {inherit src;};
  # TODO: This will most likely be replaced with a 'buildSteelHome' function to allow passing cogs and their version(s).
  steel-home = pkgs.callPackage ./steel-home.nix {inherit steel;};

  default = steel;
}
