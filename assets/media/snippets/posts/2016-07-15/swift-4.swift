// Swift
let goodPays = records.filter { ($0.last as! Int) >= 8000 }
let names = goodPays.map { "\($0[1]) \($0[2])" }  // ["Jofrey Baratheon", "Tyrion Lannister", "Eddard Stark", "Daenerys Targaryen", "Cersei Lannister"]
