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
  puts 'What a name of the station you want to create?'
  name = gets.chomp.capitalize
  if @stations.include?(name)
    puts 'Sorry, but this station already created.'
  else
    @stations.push(Station.new(name))
    puts "#{station} was created."
  end
end

#2. Create a train
def create_train
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
      puts 'Sorry, but this train already created'
    else
      @trains.push(PassengerTrain.new(number))
      puts "Train - #{number} was created."
    end
    when '2'
    if @trains.include?(number)
      puts 'Sorry, but this train already created'
    else
      @trains.push(PassengerTrain.new(number))
      puts "Train - #{number} was created."
    end
  end
end

#Create routes and manage stations in it
def create_routes
