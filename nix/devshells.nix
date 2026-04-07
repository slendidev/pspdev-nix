{ pkgs, packages }:
pkgs.mkShell {
  packages = [
    packages.psp-binutils
    packages.psp-gcc
    packages.pspsdk
    packages.psplinkusb
    packages.ebootsigner
    packages.psp-cmake
  ];
}
