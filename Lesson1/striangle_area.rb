puts 'In order to fint out the area of the triangle, enter his base and height in centimeters'
print 'The base is: '
base = gets.to_i
print 'The height is: '
height = gets.to_i
if base > 0 && height > 0
#adding calculation of the area
area = (1.0/2) * base * height
  puts "The area of the triangle is: #{area} centimeters."
else
  puts "Values can't be zero, less then zero, or some word!"
end
