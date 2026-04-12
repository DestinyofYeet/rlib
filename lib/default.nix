{
  mkMerge = builtins.wasm {
    path = ./mkMerge.wasm;
    function = "mkMerge";
  };

  mkIf =
    condition: value:
    (builtins.wasm {
      path = ./mkIf.wasm;
      function = "mkIf";
    } { inherit condition value; });
}
