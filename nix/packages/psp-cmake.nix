{
  stdenv,
  makeWrapper,
  cmake,
  pspsdk,
}:
stdenv.mkDerivation {
  pname = "psp-cmake";
  version = "ce8127a5d7de5a8774bf1f7f152501dae0a800ae";

  dontUnpack = true;
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cat > "$out/bin/psp-cmake" <<'EOF'
    #!${stdenv.shell}
    if [ -z "''${PSPDEV}" ]; then
      export PSPDEV="${pspsdk}"
    fi
    exec ${cmake}/bin/cmake -DCMAKE_TOOLCHAIN_FILE="''${PSPDEV}/psp/share/pspdev.cmake" "$@"
    EOF
    chmod +x "$out/bin/psp-cmake"
    runHook postInstall
  '';
}
