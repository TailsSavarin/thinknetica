# frozen_string_literal: true

puts "Hello, let's find out!"
puts 'If triangle is rectangular, isosceles or equilateral'
puts 'Write the values of the three his sides'
print '1st side: '
side_a = gets.to_i
print '2nd side: '
side_b = gets.to_i
print '3d side: '
side_c = gets.to_i

a, b, h = [side_a, side_b, side_c].sort
if h**2 == a**2 + b**2
  puts 'Triangle is recangular'
elsif a == b && a == h
  puts 'Triangle is equilateral and isosceles'
elsif a == b || a == h || b == h
  puts 'Triangle is isosceles'
else
  puts 'Triangle is miscellaneous'
end
