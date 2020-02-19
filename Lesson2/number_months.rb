# frozen_string_literal: true

months = {
  January: 31,
  February: 29,
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31
}

months_new = months.select { |_month, day| day == 30 }
months_new.to_a.join(', ')
puts "Months which the total number of days is thirty: #{months_new.keys}"
