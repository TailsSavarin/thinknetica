puts 'Please enter you name'
name = gets.chomp.capitalize
puts "Hello #{name}, I'm a program that calculates your ideal weight, wanna know it, write yes or no!"
answer = gets.chomp.downcase
case answer
when 'yes'
  puts 'Good, tell me, how tall are you in centimeters?'
  height = gets.to_i
  #Add variable
  ideal_weight = (height - 110)*1.15
  if ideal_weight > 0
    puts "#{name}, your ideal weight is #{ideal_weight} killograms"
  elsif heigh = String
    puts "Sorry, I didn't understand you."
  else
    puts "Woops, your weight is already optimal, don't worry about it!"
  end
when 'no'
  puts 'Well, goodbye then!'
else
  puts "Sorry, I didn't understand you."
end
