struct ComplexNumber: CustomStringConvertible {
  var re: Double = 0
  var im: Double = 0

  init(re: Double, im: Double) {
    self.re = re
    self.im = im
  }

  var description: String {
    if self.isNaN() {
      return "C{NaN}"
    }
    
    if im == 0 {
      return "R{\(re)}"
    }
    
    let imSign = im > 0 ? "+" : "-"
    return "C{\(re) \(imSign) \(abs(im))i}"
  }
  
  func modulus() -> Double {
    return sqrt(re*re + im*im)
  }

  func argument() -> (Double, Double) {
    return (re, im)
  }
}
