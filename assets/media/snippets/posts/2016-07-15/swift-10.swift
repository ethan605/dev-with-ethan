// Swift
let lastNameGroups = fullNames.reduce([String: [String]]()) { (temp: [String: [String]], fullName) in
  var temp = temp

  let (firstName, lastName) = fullName
  if temp[lastName] == nil { temp[lastName] = [] }

  temp[lastName]!.append(firstName)
  return temp
}
