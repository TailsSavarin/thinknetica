# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'helper_methods.rb'

class Interface
  attr_reader :stations, :trains, :routes, :wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def main_menu
    loop do
      puts MAIN_MENU
      print 'Write your answer here --> '
      main_choice = gets.chomp.to_i
      case main_choice
      when 1
        station_management
      when 2
        train_management
      when 3
        route_management
      when 0
        break
      else
        puts 'Error...'
      end
    end
  end

  def station_management
    puts STATIONS_MENU
    print 'Write your answer here --> '
    station_choice = gets.chomp.to_i
    case station_choice
    when 1
      create_station
    when 2
      list_of_stations
    when 3
      trains_at_stations
    when 4
      wagons_list
    when 0
      main_menu
    end
    puts 'Error...'
  end

  def train_management
    puts TRAINS_MENU
    print 'Write your answer here --> '
    train_choice = gets.chomp.to_i
    case train_choice
    when 1
      create_train
    when 2
      train_move_forward
    when 3
      train_move_back
    when 4
      add_wagon_for_train
    when 5
      delete_wagon_from_train
    when 6
      wagon_volume_action
    when 0
      main_menu
    else
      puts 'Error...'
    end
  end

  def route_management
    puts ROUTES_MENU
    print 'Write your answer here --> '
    route_choice = gets.chomp.to_i
    case route_choice
    when 1
      create_route
    when 2
      route_add_delete_stations
    when 3
      route_assignment_for_train
    when 0
      main_menu
    else
      puts 'Error...'
    end
  end

  private

  def create_station
    print 'Enter name of the station --> '
    name = gets.chomp
    if find_station(name)
    else
      @stations.push(Station.new(name))
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    print 'Enter number of the train --> '
    number = gets.chomp
    puts "Select a type for '#{number}' train?"
    puts "-- Type '1' for Passenger train"
    puts "-- Type '2' for Cargo train"
    type = gets.chomp.to_i
    case type
    when 1
      if find_train(number)
      else
        @trains.push(PassengerTrain.new(number))
      end
    when 2
      if find_train(number)
      else
        @trains.push(CargoTrain.new(number))
      end
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    puts 'Select first station'
    first_station = station_select(@staitons)
    puts 'Select last station'
    last_station = station_select(@stations)
    @routes.push(Route.new(first_station, last_station))
  end

  def route_add_delete_stations
    current_route = route_select(@routes)
    puts "-- Type '1' if you want to add station"
    puts "-- Type '2' if you want to delete station"
    action = gets.chomp.to_i
    case action
    when 1
      current_station = station_select(@stations)
      current_route.add_station(current_station)
    when 2
      current_station = station_select(@stations)
      current_route.delete_station(current_station)
    else
      puts 'Error...'
    end
  end

  def route_assignment_for_train
    current_train = train_select(@trains)
    current_route = route_select(@routes)
    current_train.route_assignment(current_route)
  end

  def add_wagon_for_train
    current_train = train_select(@trains)
    if current_train.type == 'passenger'
      print 'Indicate the number of seats --> '
      seats = gets.to_i
      current_train.add_wagon(PassengerWagon.new(seats))
      @wagons.push(PassengerWagon.new(seats))
    elsif current_train.type == 'cargo'
      print 'Indicate the cargo volume --> '
      volume = gets.to_i
      current_train.add_wagon(CargoWagon.new(volume))
      @wagons.push(CargoWagon.new(volume))
    end
  end

  def delete_wagon_from_train
    current_train = train_select(@trains)
    current_train.delete_wagon
  end

  def train_move_back
    current_train = train_select(@trains)
    puts "Train: '#{current_train.number}' move on station: '#{current_train.previous_station.name.capitalize}'\n... "
    current_train.move_back
  end

  def train_move_forward
    current_train = train_select(@trains)
    puts "Train: '#{current_train.number}' move on station: '#{current_train.next_station.name.capitalize}'\n... "
    current_train.move_forward
  end

  def list_of_stations
    puts 'List of the stations:'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name.capitalize}" }
  end

  def trains_at_stations
    @stations.each do |station|
      puts "Station '#{station.name.capitalize}'"
      puts 'Trains at the station:'
      station.trains_block { |train| puts "-- Train: '#{train.number}' # type: '#{train.type}' # number of wagons: '#{train.wagons.size}'" }
    end
  end

  def wagons_list
    current_station = station_select(@stations)
    puts "Complete train information at '#{current_station.name.capitalize}' Station:"
    current_station.trains_block do |train|
      train.wagons_block do |wagon|
        wagon_number = 0
        puts "Train #{train.number}: #{wagon_number += 1}. '#{wagon.type}'"
        if wagon.type == 'passenger'
          puts "Total seats: '#{wagon.seats}' # free seats: '#{wagon.free_seats}' # taken seats: '#{wagon.taken_seats}'"
        elsif wagon.type == 'cargo'
          puts "Total volume: '#{wagon.volume}' #vailable volume: '#{wagon.available_volume}#' occupied volume: '#{wagon.occupied_volume}'"
        end
      end
    end
  end

  def wagon_volume_action
    current_wagon = wagon_select(@wagons)
    if current_wagon.type == 'passenger'
      puts 'One seat is taken'
      current_wagon.take_seat
    elsif current_wagon.type == 'cargo'
      puts "Write your volume (available volume is '#{current_wagon.available_volume}')"
      quantity = gets.chomp.to_i
      current_wagon.take_volume(quantity)
    end
 
  def wagon_select(_wagons)
    puts 'Type the number of the wagon you want to select'
    puts 'Wagons list:'
    @wagons.map.with_index { |wagon, index| puts "#{index}. type: #{wagon.type}" }
    wagon_number = gets.chomp.to_i
    @wagons[wagon_number]
  end

  def route_select(_routes)
    puts 'Type the number of the route you want to select'
    puts 'Routes list:'
    @routes.map.with_index { |route, index| puts "#{index}. route: #{route.stations_list.map(&:name)}." }
    route_number = gets.chomp.to_i
    @routes[route_number]
  end

  def station_select(_stations)
    puts 'Type the number of the station you want to select'
    puts 'Stations list:'
    @stations.map.with_index { |station, index| puts "#{index}. station: '#{station.name.capitalize}'." }
    station_number = gets.chomp.to_i
    @stations[station_number]
  end

  def train_select(_trains)
    puts 'Type the number of the train you want to select'
    puts 'Trains list:'
    @trains.map.with_index { |train, index| puts "#{index}. train: '#{train.number}'." }
    train_number = gets.chomp.to_i
    @trains[train_number]
  end

  def find_station(station_name)
    @stations.find { |station| station.name == station_name }
  end

  def find_train(train_number)
    @trains.find { |train| train.number == train_number }
  end
end
