extension String {
  func toInt() -> Int {
    let numberFormatter = NSNumberFormatter()
    
    if let number = numberFormatter.numberFromString(self) {
      return Int(round(number.doubleValue))
    } else {
      return 0
    }
  }
}

"12".toInt()                // 12
"12.1".toInt()              // 12
"12.9".toInt()              // 13
