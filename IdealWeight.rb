puts "Please enter you name"
name = gets.chomp.capitalize
puts "Hello #{name}, I'm a program that calculates your ideal weight, wanna know it, write yes or no!"
answer = gets.chomp.downcase
case answer
when 'yes'
  puts "Good, tell me, how tall are you in centimeters?"
  height = gets.to_i
  if (height.to_i - 110)*1.15 > 0
    puts "#{name}, your ideal weight is #{((height - 110)*1.15).round(0)} killograms"
  else
    puts "Woops, your weight is already optimal, don't worry about it!"
  end
when 'no'
  puts "Well, goodbye then!"
else
  puts "Sorry, I didn't understand you."
end
