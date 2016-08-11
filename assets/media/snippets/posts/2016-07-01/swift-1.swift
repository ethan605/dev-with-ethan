extension Int {
  func add(otherNum: Int) -> Int {
    return self + otherNum
  }
  
  func multiply(otherNum: Int) -> Int {
    return self * otherNum
  }
}

var number: Int = 10
number.add(2).multiply(5)                   // (10 + 2) * 5 = 60
