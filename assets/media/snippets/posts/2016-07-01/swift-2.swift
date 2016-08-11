extension Int {
  func divide(otherNum: Int) -> Int? {
    if otherNum == 0 {
      return nil
    }

    return self / otherNum
  }
}

number.divide(0)?.add(10)
