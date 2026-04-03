{
  mkMerge = builtins.wasm {
    path = ./mkMerge.wasm;
    function = "mkMerge";
  };
}
