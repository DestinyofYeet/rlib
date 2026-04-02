use std::collections::HashMap;

use nix_wasm_rust::{Type, Value, warn};

#[unsafe(no_mangle)]
pub extern "C" fn mkMerge(arg: Value) -> Value {
    let list = arg.get_list();

    warn!("{list:?}");

    let mut new_values = HashMap::new();

    for elem in list.into_iter() {
        for (key, value) in elem.get_attrset().into_iter() {
            match value.get_type() {
                Type::Int
                | Type::Float
                | Type::Bool
                | Type::String
                | Type::Path
                | Type::Null
                | Type::List
                | Type::Function => {
                    new_values.insert(key, value);
                }
                Type::Attrs => {
                    warn!("attrs")
                }
            }
        }
    }

    let values = new_values
        .iter()
        .map(|(key, value)| (key.as_str(), *value))
        .collect::<Vec<(&str, Value)>>();

    Value::make_attrset(values.as_slice())
}
