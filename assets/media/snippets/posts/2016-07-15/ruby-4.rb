# Ruby
good_pays = records.select {|r| r.last >= 8000}
names = good_pays.map {|r| "#{r[1]} ##{r[2]}"}     # ["Jofrey Baratheon", "Tyrion Lannister", "Eddard Stark", "Daenerys Targaryen", "Cersei Lannister"]
