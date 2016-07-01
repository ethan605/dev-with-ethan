//: Playground - noun: a place where people can play

import Foundation

var originalInt: Int = 0

var optionalInt: Int? = nil
print(optionalInt)
"optionalInt = \(optionalInt)"

optionalInt = 10
print(optionalInt!)
"optionalInt = \(optionalInt)"

var autoUnwrap: Int! = nil
print(autoUnwrap ?? "")

autoUnwrap = 10
print(autoUnwrap)
"optionalInt = \(autoUnwrap)"

optionalInt = nil
optionalInt = 10

if let checkedInt = optionalInt {
  print(checkedInt)
  "checkedInt = \(checkedInt)"
} else {
  print("nil")
  "no value for checkedInt"
}