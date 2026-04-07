{
  lib,
  stdenv,
  cmake,
  psp-cmake,
  psp-binutils,
  psp-gcc,
  pspsdk,
}:
args@{
  nativeBuildInputs ? [ ],
  buildInputs ? [ ],
  buildSystem ? null,
  ...
}:
let
  useCmake =
    if buildSystem != null then
      buildSystem == "cmake"
    else
      builtins.elem cmake nativeBuildInputs
      || builtins.elem psp-cmake nativeBuildInputs
      || builtins.elem cmake buildInputs
      || builtins.elem psp-cmake buildInputs;

  commonEnv = {
    PSPDEV = "${pspsdk}";
    PSPSDK = "${pspsdk}/psp/sdk";
    PSPDIR = "${pspsdk}/psp/sdk";
  };

  commonNativeBuildInputs =
    [
      psp-binutils
      psp-gcc
      pspsdk
    ]
    ++ lib.optionals useCmake [ psp-cmake ];
in
stdenv.mkDerivation (
  args
  // {
    nativeBuildInputs = lib.unique (commonNativeBuildInputs ++ nativeBuildInputs);
    inherit buildInputs;
    env = (args.env or { }) // commonEnv;
  }
  // lib.optionalAttrs useCmake {
    configurePhase = args.configurePhase or ''
      runHook preConfigure
      psp-cmake -S . -B build ''${cmakeFlags:+$cmakeFlags}
      runHook postConfigure
    '';

    buildPhase = args.buildPhase or ''
      runHook preBuild
      cmake --build build -j$NIX_BUILD_CORES
      runHook postBuild
    '';

    installPhase = args.installPhase or ''
      runHook preInstall
      cmake --install build --prefix "$out"
      runHook postInstall
    '';
  }
)
