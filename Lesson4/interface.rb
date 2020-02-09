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
  
  def seed
    station1 = Station.new('test1')
    station2 = Station.new('test2')
    station3 = Station.new('test3')
    station4 = Station.new('test4')

    route1 = Route.new(station1, station2)
    route2 = Route.new(station3, station4)

    passenger_train = PassengerTrain.new('123')
    cargo_train = CargoTrain.new('456')

    @stations = [station1, station2, station3, station4]
    @trains = [passenger_train, cargo_train]
    @routes = [route1, route2]
  end

  def create_station
    print 'Enter name of the station --> '
    name = gets.chomp
    if find_station(name)
      puts "Station: '#{name}' already exists."
    else 
      @stations.push(Station.new(name))
      puts "Station: '#{name}' was successfully created."
    end
  end

  def create_train
    print "Enter number of the train --> \n "
    number = gets.chomp.to_i
    puts "Select a type for your train?\n "
    puts "-- Type '1' for Passenger train."
    puts "-- Type '2' for Cargo train."
    type = gets.chomp.to_i

    case type
      when 1
        if find_train(number)
          puts "Passenger train: '#{number}' already exists."
        else
          @trains.push(PassengerTrain.new(number))
          puts "Train: '#{number}' was successfully created."
        end
      when 2
        if find_train(number)
          puts "Train: '#{number}' already exists."
        else
          @trains.push(CargoTrain.new(number))
          puts "Cargo train: '#{number}' was successfully created."
        end
    end
  end

  def create_route
    puts 'Select first station'
    first_station = station_select(@staitons)
    puts 'Select last station'
    last_station = station_select(@stations)
    @routes.push(Route.new(first_station, last_station))
    puts 'Route was successfully created.'
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
        puts 'Station was successfully added. '
      when 2
        current_station = station_select(@stations)
        current_route.delete_station(current_station)
        puts 'Station was successfully deleted.'
      else 
        puts "Error..."
    end
  end

  def route_assignment_for_train
    current_train = train_select(@trains)
    current_route = route_select(@routes)
    current_train.route_assignment(current_route)
    puts 'Route has been assigned.'
  end

  def add_wagon_for_train
    current_train = train_select(@trains)
    if current_train.class == PassengerTrain
      current_train.add_wagon(PassengerWagon.new)
      puts 'Passenger wagon was added.'
    elsif current_train.class == CargoTrain
      current_train.add_wagon(CargoWagon.new)
      puts 'Cargo wagon was added.'
    end
  end
  
  def delete_wagon_from_train
    current_train = train_select(@trains)
    current_train.delete_wagon
    puts 'Wagon was successfully deleted.'
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
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def trains_on_station
    @stations.each { |station| puts "Station: '#{station.name}' - trains: #{station.trains_list.map(&:number)}." }
  end
    
private

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

