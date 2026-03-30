use nix_wasm_rust::{Value, warn};

#[unsafe(no_mangle)]
pub extern "C" fn test(arg: Value) -> Value {
    warn!("Hello, world!");

    arg
}
