extension Array where Element: OptionalType {
  public func compact() -> [Element] {
    return self.filter { $0.optional != nil }
  }
}
