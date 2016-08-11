func genericsMax<T where T: Comparable>(number1: T, _ number2: T) -> T {
  return number1 > number2 ? number1 : number2
}
