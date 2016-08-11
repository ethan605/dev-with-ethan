# Ruby
good_pay_names = names.reduce {|temp, name|
  temp.empty? ? name : temp + ", ##{name}"
}
puts(good_pay_names)    # Jofrey Baratheon, Tyrion Lannister, Eddard Stark, Daenerys Targaryen, Cersei Lannister
