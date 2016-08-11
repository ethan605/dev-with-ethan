// Swift
let fullNames: [(String, String)] = records.map { ($0[1] as! String, $0[2] as! String) }
let lastNameGroups = fullNames.reduce([String: [String]]()) { (var temp: [String: [String]], fullName) in
  let (firstName, lastName) = fullName
  if temp[lastName] == nil { temp[lastName] = [] }

  temp[lastName]!.append(firstName)
  return temp
}

print(lastNameGroups)   // ["Stark": ["Eddard"], "Lannister": ["Tyrion", "Cersei"], "of Lys": ["Varys"], "Targaryen": ["Daenerys"], "Baratheon": ["Robert", "Jofrey"], "Drogo": ["Khal"], "Snow": ["Jon"], "Baelish": ["Petyr"]]
