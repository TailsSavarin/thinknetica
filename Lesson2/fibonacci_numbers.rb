array = [0, 1]
array.each do |x|
  next unless (x = array[-1] + array[-2]) < 100
  array << x
end 
print array
