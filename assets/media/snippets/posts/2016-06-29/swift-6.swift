prefix func -(c1: ComplexNumber) -> ComplexNumber {
  return c1.reflection()
}

func +(c1: ComplexNumber, c2: ComplexNumber) -> ComplexNumber {
  return c1.add(c2)
}

func -(c1: ComplexNumber, c2: ComplexNumber) -> ComplexNumber {
  return c1.subtract(c2)
}

func *(c1: ComplexNumber, c2: ComplexNumber) -> ComplexNumber {
  return c1.multiply(c2)
}

func *(c1: ComplexNumber, factor: Double) -> ComplexNumber {
  return c1.multiply(factor)
}

func /(c1: ComplexNumber, c2: ComplexNumber) -> ComplexNumber {
  return c1.divide(c2)
}

func /(c1: ComplexNumber, factor: Double) -> ComplexNumber {
  return c1.divide(factor)
}
