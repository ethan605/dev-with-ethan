var autoUnwrap: Int! = nil
print(autoUnwrap)                       // fatal error: unexpectedly found nil while unwrapping an Optional value

autoUnwrap = 10
print(autoUnwrap)                       // 10
"optionalInt = \(autoUnwrap)"           // "optionalInt = 10"
