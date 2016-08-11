extension String {
  func toInt(rounded: Bool = true) -> Int {
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
