# Ruby
all_salaries = records.map {|r| r.last}
total_pays = all_salaries.reduce(:+)
puts(total_pays)        # 113500
