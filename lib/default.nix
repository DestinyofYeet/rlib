{
  mkMerge = builtins.wasm {
    path = ./mkmerge_wasm.wasm;
    function = "mkMerge";
  };
}
