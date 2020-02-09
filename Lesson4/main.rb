require_relative 'interface'

interface = Interface.new
interface.seed

puts "Welcome to the railway management program!\n "

loop do
  puts "What would you like to do?\n "
  puts "-- Type '1' to create a station.\n "
  puts "-- Type '2' to create a train.\n "
  puts "-- Type '3' to create a route.\n "
  puts "-- Type '4' to assign a train route.\n "
  puts "-- Type '5' to add or delete station in route.\n "
  puts "-- Type '6' to add wagons to the train.\n "
  puts "-- Type '7' to delete wagons from the train.\n "
  puts "-- Type '8' to move train front.\n "
  puts "-- Type '9' to move train back.\n "
  puts "-- Type '10' to view the list of stations.\n "
  puts "-- Type '11' to view the list of trains at the station.\n "
  puts "-- Type '12' to exit.\n "
  print 'Write your answer here --> '

  choice = gets.chomp.to_i
  
  case choice
  when 1
    interface.create_station
  when 2  
    interface.create_train
  when 3  
    interface.create_route
  when 4  
    interface.route_assignment_for_train
  when 5
    interface.route_add_delete_stations
  when 6  
    interface.add_wagon_for_train
  when 7  
    interface.delete_wagon_from_train
  when 8  
    interface.train_move_forward
  when 9  
    interface.train_move_back
  when 10
    interface.list_of_station
  when 11
    interface.trains_on_station
  when 12  
    puts "Good bye!"
    break
  else
    puts "Error..."
  end
end

