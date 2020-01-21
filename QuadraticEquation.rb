puts "Enter three (a,b,c) coefficients and I wll calculate the discriminan and roots of the equation if we will have them."
print "coefficient a = "
a = gets.chomp
print "coefficient b = "
b = gets.chomp
print "coefficient c = "
c = gets.chomp
#Discriminant calculations
d = b.to_i**2.0 - 4*a.to_i*c.to_i
if d > 0
  puts "Discriminant is: #{d}, X1 is: #{((-b.to_i + Math.sqrt(d.to_i))/(2.0*a.to_i)).round(1)} and X2 is: #{((-b.to_i - Math.sqrt(d.to_i))/(2.0*a.to_i)).round(1)
}"
elsif d == 0
  puts "Discriminant is: 0 and X1 = X2 = #{((-b.to_i + Math.sqrt(d.to_i))/(2.0*a.to_i)).round(1)}"
else
  puts "Discriminant is: #{d} (less then zero), no solution roots."
end
