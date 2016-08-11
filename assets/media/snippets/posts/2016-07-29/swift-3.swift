public func compact() -> [Element] {
  return self.filter {
    print($0, $0 != nil)
    return $0 != nil
  }
}
