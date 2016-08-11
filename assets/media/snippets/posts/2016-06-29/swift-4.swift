func reflection() -> ComplexNumber {
  var ref = self
  ref.im = -self.im
  return ref
}

func reciprocal() -> ComplexNumber {
  if self.isZero() {
    return ComplexNumber.NaN
  }
  
  var rec = ComplexNumber()
  let sumOfSquares = self.re*self.re + self.im*self.im
  rec.re = self.re / sumOfSquares
  rec.im = self.im / sumOfSquares
  return rec
}

func divide(otherNumber: ComplexNumber) -> ComplexNumber {
  if otherNumber.isZero() {
    return ComplexNumber.NaN
  }
  
  var result = ComplexNumber()
  
  let sumOfSquares = otherNumber.re*otherNumber.re + otherNumber.im*otherNumber.im
  result.re = (self.re*otherNumber.re + self.im*otherNumber.im) / sumOfSquares
  result.im = (self.im*otherNumber.re - self.re*otherNumber.im) / sumOfSquares
  return result
}
