{
  rustPlatform,
  lib,
  pkgs,
  ...
}:

rustPlatform.buildRustPackage {
  pname = "rust-nix-lib";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    lld
  ];

  cargoHash = "sha256-gSyWKxnFHJoruAM2K7PEYUjAy9JKOG/hMrdNC4SNy/4=";

  buildPhase = ''
    cargo build -r --target wasm32-unknown-unknown
  '';

  installPhase = ''
    mkdir -p $out
    mkdir $out/lib

    cp target/wasm32-unknown-unknown/release/mkmerge_wasm.wasm $out/lib/mkmerge_wasm.wasm
  '';

  meta = with lib; {
    description = "A program";
    license = licenses.gpl2;
    platforms = platforms.all;
  };
}
