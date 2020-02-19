# frozen_string_literal: true

food_basket = {}
total_sum = 0
total_sum.to_f

puts 'Hello, to make a purchase, please enter the data below'
puts "(when you're done with your list, just write *stop*)"

loop do
  print "The product's name: "
  product_name = gets.chomp
  break if product_name == 'stop'

  print "The product's price: "
  product_price = gets.to_f
  print "The product's count: "
  product_count = gets.to_f

  products = { price: product_price, count: product_count }
  food_basket[product_name] = products
end

if food_basket.empty?
  puts 'Sorry, but your basket is empty, please try again!'
else
  puts 'Currently in your basket is:'
  puts 'Name - [Price, Count]'
  food_basket.map { |x, y| puts "#{x.capitalize} - #{y.values}" }

  puts 'The final price for each product:'
  puts 'Name - price'
  food_basket.each do |key, value|
    sum_product_price = value[:price] * value[:count]
    total_sum += sum_product_price
    puts "#{key.capitalize} - #{sum_product_price}"
  end
  puts "Total purchase amount is: #{total_sum}"
end
