require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

#Create empty arrays for data
@stations = []
@trains = []
@routes = []

#Create main menu
def main_nemu
  puts "What would you like to do?"
  puts "-- Type '1' to create a station."
  puts "-- Type '2' to create a train."
  puts "-- Type '3' to create a route."
  puts "-- Type '4' to assign a train route."
  puts "-- Type '5' to add wagons to the train."
  puts "-- Type '6' to delete wagons from the train."
  puts "-- Type '7' to move train back and front."
  puts "-- Type '8' to view the list of stations and list of trains at the station."
  puts "-- Type '0' to exit."
end

#1. Create a station
def create_station
  puts "- Type '1' to create a station."
  puts "- Type '0' to return to the menu."

  create_station_choice = gets.chomp.to_i
  case create_station_choice 
    when '1'
      puts 'What a name of the station you want to create?'
      name = gets.chomp.capitalize
      if @stations.include?(name)
        puts 'Sorry, but this station already created.'
      else
        @stations.push(Station.new(name))
        puts "Station: #{name}, was created."
      end
    when '0'
      main_menu
    end
  create_station
end

#2. Create a train
def create_train
  puts "- Type '1' to create a train."
  puts "- Type '0' to return to the main menu."

  create_train_choice = gets.chomp.to_i
  case create_train_choice
    when '1'
      puts 'What a number of the train you want to create?'
      puts 'For example -- 123 -- '
      number = gets.chomp.to_i

      puts 'Select a type of the train you want to create?'
      puts "-- Type '1' for Passenger train."
      puts "-- Type '2' for Cargo train."

      type = gets.chomp.to_i
      case type
        when '1'
          if @trains.include?(number)
            puts 'Sorry, but this train already created.'
          else
            @trains.push(PassengerTrain.new(number))
            puts "Train - #{number}, was created."
          end
        when '2'
          if @trains.include?(number)
            puts 'Sorry, but this train already created.'
          else
            @trains.push(CargoTrain.new(number))
            puts "Train - #{number}, was created."
          end
        end
    when '0'
      main_menu
    end
  create_train
end

#Create routes and manage stations in it
def actions_with_route
  puts "- Type '1' to create a route."
  puts "- Type '2' to add station to route."
  puts "- Type '3' to delete station from route."
  puts "- Type '0' to return to the main menu."
  actions = gets.chomp.to_i
  case actions
    when '1'
      puts 'To create a route, you need to select the starting and ending stations.'
      puts 'List of avaliable station:'
      @stations.each.with.index(1) { |name, index| puts "#{index}. #{name}" }

      print 'Enter the starting station number: '
      first_station = gets.chomp.to_i
      @first_station = @stations[first_station]

      print 'Enter the ending station number: '
      last_station = gets.chomp.to_i
      @last_station = @stations[last_station]

      puts 'Creating a route...'
      @routes.push(Route.new(@first_station, @last_station))
      puts 'Route was created!'
    when '2'
      puts 'To add a station to the route, you need to select the station.'
      puts 'List of avalieble stations:'
      @stations.ecah.with.index(1) { |name, index| puts "#{index}. #{name}" }

      print 'Enter the station number: '
      station_number = gets.chomp.to_i
      
      puts 'Select the route number to which you want to add the station.'
      puts 'Route list:'
      @routes.each.with.index(1) { |route, index| puts "#{index}. #{route}" }
      
      print 'Enter the route number: '
      route_number = gets.chomp.to_i

      @select_route = @routes[route_number]
      puts "You choosed: #{@select_route}."

      puts 'Adding the station...'
      station_route = @stations[station_number]
      @select_route.add_sation(sation_route)
      puts 'Station was added!'
    when '3'
      puts 'To delete a station from the route, you need to select the station.'
      puts 'List of avalieble stations:'
      @stations.ecah.with.index(1) { |name, index| puts "#{index}. #{name}" }

      print 'Enter the station number: '
      station_number = gets.chomp.to_i
      
      puts 'Select the route number from which you want to delete the station.'
      puts 'Route list:'
      @routes.each.with.index(1) { |route, index| puts "#{index}. #{route}" }
      
      print 'Enter the route number: '
      route_number = gets.chomp.to_i

      @select_route = @routes[route_number]
      puts "You choosed: #{@select_route}."

      puts 'Deleting the station...'
      station_route = @stations[station_number]
      @select_route.delete_sation(sation_route)
      puts 'Station was deleted from the route.'
    when '0'
      main_menu
    end
    actions_with_route
end

