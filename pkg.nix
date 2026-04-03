{
  rustPlatform,
  lib,
  pkgs,
  ...
}:
let
  functions = [
    "mkMerge"
    "mkIf"
  ];
in

rustPlatform.buildRustPackage {
  pname = "rust-nix-lib";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    lld
  ];

  cargoHash = "sha256-ieVYgpFCT4+ST7PcxInHxzu5jiIx2JjPZHR61cZjfQQ=";

  buildPhase = ''
    cargo build -r --target wasm32-unknown-unknown --all-targets
  '';

  installPhase = ''
    mkdir -p $out
    mkdir $out/lib

    ${builtins.concatStringsSep "\n" (
      map (
        function: "cp target/wasm32-unknown-unknown/release/${function}.wasm $out/lib/${function}.wasm"
      ) functions
    )}
  '';

  meta = with lib; {
    description = "A program";
    license = licenses.gpl2;
    platforms = platforms.all;
  };
}
