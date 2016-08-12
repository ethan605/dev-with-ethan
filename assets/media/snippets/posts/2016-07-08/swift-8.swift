func objectGreeting<T: Base>(classType: T.Type) -> String {
  print(T.announce())
  return classType.init().greet()
}

objectGreeting(Base.self)           // "Hi, I'm a Base"
objectGreeting(Person.self)         // "Hi, I'm a Person"
objectGreeting(Animal.self)         // "Hi, I'm a Animal"
