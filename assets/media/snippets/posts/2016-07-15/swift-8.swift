// Swift
let goodPayNames = names.reduce("") { (temp, name) in
  if temp == "" {
    return name
  } else {
    return temp + ", \(name)"
  }
}
print(goodPayNames)     // Jofrey Baratheon, Tyrion Lannister, Eddard Stark, Daenerys Targaryen, Cersei Lannister
