puts "Hello, let's find out if the triangle is rectangular, isosceles or equilateral, write the values of the three his sides"
print "1st side: "
a = gets.to_i
print "2nd side: "
b = gets.to_i
print "3d side: "
c = gets.to_i

#Add array
sides = [a, b, c].sort!

if sides[2]**2 == sides[1]**2 + sides[0]**2
  puts "Triangle is recangular."
elsif a == b && a == c
  puts "Triangle is equilateral and isosceles."
elsif a == b || a == c || b == c
  puts "Triangle is isosceles."
else
  puts "Triangle is miscellaneous."
end 
