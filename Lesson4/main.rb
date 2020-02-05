require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

#Adding empty arrays for data

@stations = []
@trains = []
@routes = []
@wagons = []

#Adding main menu

def main_menu
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

#Create a station
def station_name
  puts 'What a nme of the station you want to create?'
  station_name = gets.chomp.capitalize
end

def create_station(name)
  station = Station.new(name)
  @stations.push(station)
  puts "#{station} was created."
end

#Just a main menu plan
main_menu
choice = gets.to_f
case choice
  when '1'
  when '2'
  when '3'
  when '4'
  when '5'
  when '6'
  when '7'
  when '8'
  when '0'
  else
end

