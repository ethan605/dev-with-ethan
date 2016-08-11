// Swift
let allSalaries = records.map { $0.last as! Int }
let totalPays = allSalaries.reduce(0) { (temp, salary) in
  print("Reduce step: temp = \(temp), salary = \(salary)")
  return temp + salary
}
print("Total pays = \(totalPays)")
