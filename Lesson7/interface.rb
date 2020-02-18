require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

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
      puts "---------------    Control  Panel     ---------------\n "
      puts "---------------       Type '1'        ---------------   "
      puts "--------------- #Stations management# ---------------\n "
      puts "---------------       Type '2'        ---------------   "
      puts "---------------  #Trains management#  ---------------\n "
      puts "---------------       Type '3'        ---------------   "
      puts "---------------  #Routes management#  ---------------\n "
      puts "---------------       Type '0'        ---------------   "
      puts "---------------         Exit          ---------------\n "

      print "Write your answer here --> "
      main_choice = gets.chomp.to_i
      
      case main_choice
      when 1 
        station_management
      when 2  
        train_management
      when 3
        route_management
      when 0
        puts 'Good bye!'
        break
      else
        puts 'Error...'
      end
    end
  end

  def station_management
    puts "- Type '1' to create a station ----------------------\n "
    puts "- Type '2' to view the list of stations -------------\n "
    puts "- Type '3' to view the list of trains at the stations\n "
    puts "- Type '4' to view list of wagons at the station ----\n "
    puts "- Type '0' to return to the main menu ---------------\n "
    print "Write your answer here --> "

    station_choice = gets.chomp.to_i

    case station_choice
    when 1
      create_station
      puts 'Station was created'
    when 2
      list_of_stations
    when 3
      trains_at_stations
    when 4
      wagons_list
    when 0
      main_menu
    else 
      puts 'Error...'
    end
  end

  def train_management
    puts "- Type '1' to create a train ------------------------\n "
    puts "- Type '2' to move train front ----------------------\n "
    puts "- Type '3' to move train back -----------------------\n "
    puts "- Type '4' to add wagons to the train ---------------\n "
    puts "- Type '5' to delete wagons from the train ----------\n "
    puts "- Type '6' to actions with he volume of wagons ------\n "
    puts "- Type '0' to return to the main menu ---------------\n "
    print "Write your answer here --> "

    train_choice = gets.chomp.to_i

    case train_choice
    when 1
      create_train
      puts 'Train was created'
    when 2
      train_move_forward
      puts 'Train moving front'
    when 3
      train_move_back
      puts 'Train moving back'
    when 4
      add_wagon_for_train
      puts 'Wagon was added'
    when 5
      delete_wagon_from_train
      puts 'Wagon was deleted'
    when 6
      wagon_volume_action
      puts 'Action completed successfully'
    when 0
      main_menu
    else 
      puts 'Error...'
    end
  end

  def route_management
    puts "- Type '1' to create a route ------------------------\n " 
    puts "- Type '2' to add or delete station in route --------\n "
    puts "- Type '3' to assign a train route ------------------\n "
    puts "- Type '0' to return to the main menu ---------------\n "
    print "Write your answer here --> "

    route_choice = gets.chomp.to_i

    case route_choice
    when 1 
      create_route
      puts 'Route was created'
    when 2
      route_add_delete_stations
      puts 'Action completed successfully'
    when 3
      route_assignment_for_train
      puts 'Route was assigned'
    when 0 
      main_menu
    else 
      puts 'Error...'
    end
  end

  def seed
    station1 = Station.new('TestA')
    station2 = Station.new('TestB')
    station3 = Station.new('TestC')

    route1 = Route.new(station1, station2)

    train1 = PassengerTrain.new('aaa11')
    train2 = CargoTrain.new('bbb22')

    @stations = [station1, station2, station3]
    @routes = [route1]
    @trains = [train1, train2]
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
  end

  def wagon_select(wagons)
    puts 'Type the number of the wagon you want to select'
    puts 'Wagons list:'
    @wagons.map.with_index { |wagon, index| puts "#{index}. type: #{wagon.type}" }
    wagon_number = gets.chomp.to_i
    @wagons[wagon_number]
  end 

  def route_select(routes)
    puts 'Type the number of the route you want to select'
    puts 'Routes list:'
    @routes.map.with_index { |route, index| puts "#{index}. route: #{route.stations_list.map(&:name)}." }
    route_number = gets.chomp.to_i
    @routes[route_number]
  end
  
  def station_select(stations)
    puts 'Type the number of the station you want to select'
    puts 'Stations list:'
    @stations.map.with_index { |station, index| puts "#{index}. station: '#{station.name.capitalize}'." }
    station_number = gets.chomp.to_i
    @stations[station_number]
  end

  def train_select(trains)
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


