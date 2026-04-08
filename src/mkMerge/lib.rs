use std::collections::HashMap;

use nix_wasm_rust::{Type, Value};

#[unsafe(no_mangle)]
pub extern "C" fn mkMerge(arg: Value) -> Value {
    let list = arg.get_list();

    let mut new_values: HashMap<String, Value> = HashMap::new();

    for elem in list.into_iter() {
        if is_null(&elem) {
            continue;
        }
        for (key, value) in elem.get_attrset().into_iter() {
            match new_values.remove(&key) {
                None => {
                    new_values.insert(key, value);
                }

                Some(existing) => {
                    let merged = merge_values(existing, value);
                    new_values.insert(key, merged);
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

fn merge_values(a: Value, b: Value) -> Value {
    match (a.get_type(), b.get_type()) {
        (Type::Attrs, Type::Attrs) => {
            let mut merged = a.get_attrset();
            for (key, value) in b.get_attrset().into_iter() {
                match merged.remove(&key) {
                    None => {
                        merged.insert(key, value);
                    }
                    Some(existing) => {
                        let merged_new = merge_values(existing, value);
                        merged.insert(key, merged_new);
                    }
                }
            }

            let values = merged
                .iter()
                .map(|(key, value)| (key.as_str(), *value))
                .collect::<Vec<(&str, Value)>>();

            Value::make_attrset(values.as_slice())
        }

        (_, _) => b,
    }
}

fn is_null(value: &Value) -> bool {
    if let Type::Null = value.get_type() {
        return true;
    }

    false
}
