#Adding empty basket hash for products
food_basket = Hash.new(0)
#Adding total purchase amount atm
total_sum = 0
total_sum.to_f

puts 'Hello, to make a purchase, please enter the data below.'
puts "(when you're dont with your list, just write *stop* in product's name line)"

loop do
  print "The product's name: "
  product_name = gets.chomp
  if product_name == 'stop'
    break
  end

  print "The product's price: "
  product_price = gets.to_f
  print "The product's count: "
  product_count = gets.to_f 

#Adding item hash for food_basket
  products = {price: product_price, count: product_count}
  food_basket[product_name] = products 
end
#Adding a empty baske method
if food_basket.empty?
  puts "Sorry, but your basket is empty, please try again!" 
else
#Addint currently products in the basket
  puts "Currently in your basket is:"
  puts "Name - [Price, Count]"
  food_basket.map { |x, y| puts "#{x.capitalize} - #{y.values}" }

  puts "The final price for each product:" 
  puts "Name - price"
  food_basket.each do |key, value|
    sum_product_price = value[:price] * value[:count]
    total_sum += sum_product_price
    puts "#{key.capitalize} - #{sum_product_price}"
  end
  puts "Total purchase amount is: #{total_sum}"
end
