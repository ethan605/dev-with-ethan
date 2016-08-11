func max(number1: Int, _ number2: Int) -> Int {
  return number1 > number2 ? number1 : number2
}

func max(number1: Double, _ number2: Double) -> Double {
  return number1 > number2 ? number1 : number2
}

max(1, 2)               // 2
max(2.8, 1.5)           // 2.8
