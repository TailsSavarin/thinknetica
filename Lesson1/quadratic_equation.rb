# frozen_string_literal: true

puts 'Enter three (a,b,c) coefficients'
puts 'I wll calculate the discriminan and roots of the equation'
print 'coefficient a = '
a = gets.to_i
print 'coefficient b = '
b = gets.to_i
print 'coefficient c = '
c = gets.to_i
# Discriminant calculations
d = (b**2 - 4.0 * a * c).round(1)
if d.positive?
  # adding sqrtD
  sqrt_d = Math.sqrt(d)
  # adding roots
  x1 = ((-b + sqrt_d) / (2.0 * a)).round(1)
  x2 = ((-b - sqrt_d) / (2.0 * a)).round(1)
  puts "Discriminant is: #{d}, X1 is: #{x1} and X2 is: #{x2}"
elsif d.zero?
  puts "Discriminant is: 0 and X1 = X2 = #{x1}"
else
  puts "Discriminant is: #{d} (less then zero), no solution roots"
end
