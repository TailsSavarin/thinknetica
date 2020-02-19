# frozen_string_literal: true

puts 'Hello,to find out date serial number, please enter the following data'

print 'Day: '
day = gets.to_i

print 'Month: '
month = gets.to_i

print 'Year: '
year = gets.to_i

months = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

months[2] = 29 if ((year % 4).zero? && (year % 100 != 0)) || (year % 400).zero?

serial_number = months.take(month - 1).sum(day) { |_month, day_num| day_num }

puts "Date serial number is: #{serial_number}"
