{
  rustPlatform,
  lib,
  pkgs,
  ...
}:
let
  functions = [
    "mkMerge"
  ];
in

rustPlatform.buildRustPackage {
  pname = "rust-nix-lib";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    lld
  ];

  cargoHash = "sha256-y6vN0Jz0qydzm99BU93SCSyF7SduniLFEw6Wz2mn+WI=";

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
