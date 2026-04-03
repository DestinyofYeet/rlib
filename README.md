# rlib
Nix std lib written in Rust using DeterminateSystems `builtins.wasm` function.

# Installation
Flake.nix
```nix
{
  inputs = {
    nixpkgs.url = "...";

    rlib.url = "git+https://code.ole.blue/DestinyofYeet/rlib/";
  };

  outputs = {nixpkgs, ...}@inputs: let
    defaultSpecialArgs = {
      rlib = inputs.rlib.lib;
    };
  in {

    nixosConfigurations = {
      yourHost = nixpkgs.lib.nixosSystem {
        specialArgs = defaultSpecialArgs;
        ...
      };
    }
  }
}
  
```

# Examples
## mkMerge
```nix
{rlib, ...}:{

  # using normal lib.mkIf somehow breaks :(
  # use rlib.mkIf (see below) instead
  value = rlib.mkMerge [
    {
      a = { b = 2; };
    }
    {
      a = { c = 5;};
    }
    (rlib.mkIf {
      condition = ...;
      value = ...
    })
  ]
}
```

## mkIf
```nix
{rlib, ...}:{

  value = rlib.mkIf {
    condition = true; # true, false, fn call, whatever
    value = {
      someValue = 6;
    }
  }
}
  
```
