var optionalInt: Int? = nil
print(optionalInt!)                     // fatal error: unexpectedly found nil while unwrapping an Optional value

optionalInt = 10
print(optionalInt!)                     // 10
"optionalInt = \(optionalInt)"          // "optionalInt = 10"
