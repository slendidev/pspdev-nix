final: prev:
let
  packages = import ./packages {
    pkgs = final;
  };
in
packages
// {
  pspMkDerivation = import ./psp-mk-derivation.nix {
    inherit (final)
      lib
      stdenv
      cmake
      psp-cmake
      psp-binutils
      psp-gcc
      pspsdk
      ;
  };
}
