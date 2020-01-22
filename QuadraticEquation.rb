puts "Enter three (a,b,c) coefficients and I wll calculate the discriminan and roots of the equation if we will have them."
print "coefficient a = "
a = gets.to_i
print "coefficient b = "
b = gets.to_i
print "coefficient c = "
c = gets.to_i

#Discriminant calculations
d = b**2.0 - 4*a*c
if d > 0
  puts "Discriminant is: #{d}, X1 is: #{((-b + Math.sqrt(d))/(2.0*a)).round(1)} and X2 is: #{((-b - Math.sqrt(d))/(2.0*a)).round(1)}"
elsif d == 0
  puts "Discriminant is: 0 and X1 = X2 = #{((-b + Math.sqrt(d))/(2.0*a)).round(1)}"
else
  puts "Discriminant is: #{d} (less then zero), no solution roots."
end 
