static var NaN: ComplexNumber = ComplexNumber(re: Double.NaN, im: Double.NaN)

func isZero() -> Bool {
  return re == 0 && im == 0
}

func multiply(factor: Double) -> ComplexNumber {
  var result = self
  result.re *= factor
  result.im *= factor
  return result
}

func divide(factor: Double) -> ComplexNumber {
  if factor == 0 {
    return ComplexNumber.NaN
  }
  
  var result = self
  result.re /= factor
  result.im /= factor
  return result
}

func dividedBy(factor: Double) -> ComplexNumber {
  if self.isZero() {
    return ComplexNumber.NaN
  }
  
  var result = self.reciprocal()
  result = result.multiply(factor)
  return result
}
