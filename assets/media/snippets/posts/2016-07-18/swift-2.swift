extension String {
  func toInt() -> Int {
    let numberFormatter = NSNumberFormatter()
    
    if let number = numberFormatter.numberFromString(self) {
      return Int(round(number.doubleValue))
    } else {
      return 0
    }
  }
  
  func toInt(rounded: Bool) -> Int {
    let numberFormatter = NSNumberFormatter()
    
    if let number = numberFormatter.numberFromString(self) {
      if rounded {
        return Int(round(number.doubleValue))
      } else {
        return number.integerValue
      }
    } else {
      return 0
    }
  }
}

"12".toInt(false)           // 12
"12.1".toInt(false)         // 12
"12.9".toInt(false)         // 12
