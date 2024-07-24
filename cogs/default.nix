{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    legacyPackages.steelCogs = let
      inherit (self'.packages) steel;

      buildSteelCog = {
        name,
        dylib ? false,
        ...
      } @ args:
        pkgs.stdenvNoCC.mkDerivation ({
            src =
              if dylib
              then "${self'.packages.steel}/lib/${name}"
              else "${self'.packages.steel}/cogs/${name}";

            buildPhase = ''
              cp -r $src $out
            '';
          }
          // args);

      callCog = file: args: pkgs.callPackage file ({inherit buildSteelCog;} // args);
    in {
      clos = callCog ./clos.nix {};
      collections = callCog ./collections.nix {};
      colors = callCog ./colors.nix {};
      coop = callCog ./coop.nix {};
      fs = callCog ./fs.nix {};
      installer = callCog ./installer.nix {};
      lists = callCog ./lists.nix {};
      logging = callCog ./logging.nix {};
      reflection = callCog ./reflection.nix {};
      slack = callCog ./slack.nix {};

      steel-websockets = callCog ./steel-websockets.nix {inherit steel;};
    };
  };
}
