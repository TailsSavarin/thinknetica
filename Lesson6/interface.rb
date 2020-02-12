require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

class Interface
  attr_reader :stations, :trains, :routes 

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end
  
  def main_menu
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
        create_station
      when 2  
        create_train
      when 3  
        create_route
      when 4  
        route_assignment_for_train
      when 5
        route_add_delete_stations
      when 6  
        add_wagon_for_train
      when 7  
        delete_wagon_from_train
      when 8  
        train_move_forward
      when 9  
        train_move_back
      when 10
        list_of_station
      when 11
        trains_on_station
      when 12  
        puts "Good bye!"
      break
      else
        puts "Error..."
      end
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
    puts "Select a type for your train?\n "
    puts "-- Type '1' for Passenger train."
    puts "-- Type '2' for Cargo train."
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
    puts "-- Type '1' if you want to add station."
    puts "-- Type '2' if you want to delete station."
    action = gets.chomp.to_i
    case action
    when 1
      current_station = station_select(@stations)
      current_route.add_station(current_station)
    when 2
      current_station = station_select(@stations)
      current_route.delete_station(current_station)
    else 
      puts "Error..."
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
      current_train.add_wagon(PassengerWagon.new)
    elsif current_train.type == 'cargo'
      current_train.add_wagon(CargoWagon.new)
    end
  end
  
  def delete_wagon_from_train
    current_train = train_select(@trains)
    current_train.delete_wagon
  end

  def train_move_back
    current_train = train_select(@trains)
    puts "Train: '#{current_train.number}' move on station: '#{current_train.previous_station.name}'.\n... "
    current_train.move_back
    puts "Train: '#{current_train.number}' - current station: '#{current_train.current_station.name}'."
  end

  def train_move_forward
    current_train = train_select(@trains)
    puts "Train: '#{current_train.number}' move on station: '#{current_train.next_station.name}'.\n... "
    current_train.move_forward
    puts "Train: '#{current_train.number}' - current station: '#{current_train.current_station.name}'."
  end
  
  def list_of_station
    puts 'List of the stations:'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def trains_on_station
    puts 'List of the trains in the stations:'
    @stations.each { |station| puts "Station: '#{station.name}' - trains: #{station.trains_list.map(&:number)}." }
  end

  def route_select(routes)
    puts "Type the number of the route you want to select.\n "
    puts 'Routes list:'
    @routes.map.with_index { |route, index| puts "#{index}. route: #{route.stations_list.map(&:name)}." }
    route_number = gets.chomp.to_i
    @routes[route_number]
  end
  
  def station_select(stations)
    puts "Type the number of the station you want to select.\n "
    puts 'Stations list:'
    @stations.map.with_index { |station, index| puts "#{index}. station: '#{station.name}'." }
    station_number = gets.chomp.to_i
    @stations[station_number]
  end

  def train_select(trains)
    puts "Type the number of the train you want to select.\n "
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

