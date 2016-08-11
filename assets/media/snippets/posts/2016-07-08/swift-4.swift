func genericsMax<T: Comparable>(number1: T, _ number2: T) -> T {
  if T.self == Double.self {
    print("Compare Double numbers \(number1) & \(number2)")
  }
  
  return number1 > number2 ? number1 : number2
}
