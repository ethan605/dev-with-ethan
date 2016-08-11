func genericsMax<T: Comparable>(number1: T, _ number2: T) -> T {
  return number1 > number2 ? number1 : number2
}

genericsMax(1, 2)       // 2
genericsMax(2.8, 1.5)   // 2.8
