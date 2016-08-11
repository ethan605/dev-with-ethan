# Ruby
full_names = records.map {|r| [r[1], r[2]]}
last_name_groups = full_names.reduce({}) {|temp, full_name|
  first_name, last_name = full_name
  temp[last_name] ||= []
  temp[last_name] << first_name
  temp
}
puts(last_name_groups)  # {"Baratheon"=>["Robert", "Jofrey"], "Lannister"=>["Tyrion", "Cersei"], "Stark"=>["Eddard"], "Targaryen"=>["Daenerys"], "Snow"=>["Jon"], "Drogo"=>["Khal"], "Baelish"=>["Petyr"], "of Lys"=>["Varys"]}
