optionalInt = nil

if let checkedInt = optionalInt {
  print(checkedInt)
  "checkedInt = \(checkedInt)"
} else {
  print("nil")
  "no value for checkedInt"
}
