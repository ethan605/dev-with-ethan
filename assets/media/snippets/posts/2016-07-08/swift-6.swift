class Base: NSObject {
  required override init() {}

  class func announce() -> String {
    let classType = NSStringFromClass(self)
    let className = classType.componentsSeparatedByString(".").last!
    return "Using class \(className)"
  }
  
  func greet() -> String {
    let classType = NSStringFromClass(self.dynamicType)
    let className = classType.componentsSeparatedByString(".").last!
    return "Hi, I'm a \(className)"
  }
}

class Person: Base {
}

class Animal: Base {
}
