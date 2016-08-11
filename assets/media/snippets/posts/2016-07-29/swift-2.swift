extension Array {
  public func compact() -> [Element] {
    return self.filter { $0 != nil }
  }
}
