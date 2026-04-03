use nix_wasm_rust::Value;

#[unsafe(no_mangle)]
pub extern "C" fn mkIf(arg: Value) -> Value {
    let arg = arg.get_attrset();
    let condition = arg.get("condition").unwrap();
    let value = arg.get("value").unwrap();
    if condition.get_bool() {
        *value
    } else {
        Value::make_null()
    }
}
