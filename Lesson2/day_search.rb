puts 'Hello,to find out date serial number, please enter the following data'
print 'Day: '
day = gets.to_i
print 'Month: '
month = gets.to_i
print 'Year: '
year = gets.to_i
#Addin months hash
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
#Adding leap year fix                                                   
if ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)                
  months[2] = 29                                                            
end   
#Adding date serial number variable
serial_number = 0      

months.each do |key, value| 
  if key < month
    serial_number += value
  elsif key == month
    serial_number += day
  end
end

puts "Date serial number is: #{serial_number}."
    
