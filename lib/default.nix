{
  mkMerge = builtins.wasm {
    path = ./mkMerge.wasm;
    function = "mkMerge";
  };

  mkIf = builtins.wasm {
    path = ./mkIf.wasm;
    function = "mkIf";
  };
}
