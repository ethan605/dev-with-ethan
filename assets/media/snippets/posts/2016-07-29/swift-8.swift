extension Array where Element: OptionalType {
  public func unwrapped() -> [Element.Wrapped]? {
    let initial = Optional<[Element.Wrapped]>([])
    
    return self.reduce(initial) { (reduced, element) in
      reduced.flatMap { (arr) in element.optional.map { a + [$0] } }
    }
  }
}
