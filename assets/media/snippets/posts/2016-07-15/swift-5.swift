// Swift
let allSalaries = records.map { $0.last as! Int }
let totalPays = allSalaries.reduce(0, combine: +)
print(totalPays)        // 113500
