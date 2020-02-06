require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

class Interface

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

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

  #SELECT OBJECTS--------------------------------------------------------------
  def route_select
    puts 'Type the number of the route you want to select.'
    puts 'Route list:'
    @routes.each.with.index(1) { |name, index| puts "#{index}. #{name}" }
    route_number = gets.chomp.to_i
    @select_route = @routes[route_number]
    puts "You select: #{@select_route}."
  end
  
  def station_select
    puts 'Type the number of the station you want to select.'
    puts 'Station list:'
    @stations.ecah.with.index(1) { |name, index| puts "#{index}. #{name}" }
    station_number = gets.chomp.to_i
    @select_station = @stations[station_number]
    puts "You select: #{@select_station}."
  end

  def train_select
    puts 'Type the number of the train you want to select.'
    puts 'Train list:'
    @trains.each.with.index(1) { |number, index| puts "#{index}. #{number}" }
    train_number = gets.chomp.to_i
    @select_train = @trains[train_number]
    puts "You select: #{@select_train}."
  end

  def wagon_select
    puts 'Type the number of the wagon you want to select.'
    puts 'Train list:'
    @wagons.each.with.index(1) { |number, index| puts "#{index}. #{number}" }
    wagon_number = gets.chomp.to_i
    @wagon_train = @wagons[wagon_number]
    puts "You select: #{@select_wagon}."
  end
  #----------------------------------------------------------------------------
  #1. CREATE STATION-----------------------------------------------------------
  def station_name
    puts 'What a name of the station you want to create?'
    name = gets.chomp.capitalize
    @new_name = name
  end

  def station_create
    if @stations.include?(@new_name)
      puts 'Sorry, but this station alreadey created.'
      station_name
    else 
      @stations.push(Station.new(@new_name))
      puts "Station: #{@new_name}, was created."
    end
  end
  #----------------------------------------------------------------------------
  #2. CREATE TRAIN-------------------------------------------------------------
  def train_number
    puts 'What a number of the train you want to create?'
    puts 'For example -- 123 -- '
    number = gets.chomp.to_i
    @new_number = number
  end
  
  def train_create_by_type
    puts 'Select a type of the train you want to create?'
    puts "-- Type '1' for Passenger train."
    puts "-- Type '2' for Cargo train."
    type = gets.chomp.to_i
    case type
      when '1'
        if @trains.include?(@new_number)
          puts 'Sorry, but this train already created.'
          train_number
        else
          @trains.push(PassengerTrain.new(@new_number))
          puts "Train - #{@new_number}, was created."
        end
      when '2'
        if @trains.include?(@new_number)
          puts 'Sorry, but this train already created.'
          train_number
        else
          @trains.push(CargoTrain.new(@new_number))
          puts "Train - #{@new_number}, was created."
        end
    end
  end
  #----------------------------------------------------------------------------
  #3. CREATE ROUTE-------------------------------------------------------------
  def route_select_stations
    puts 'For creatin a new route, you need to select starting and ending stations.'
    puts '-- Select starting station'
    station_select
    @first_station = @select_station
    puts '-- Select ending station'
    station_select
    @last_station = @select_station
  end
  
  def route_create
    puts 'Creating a route...'
    @routes.push(Route.new(@first_station, @last_station))
    puts 'Route was created!'
  end
  
  def route_station_add
    puts 'To add a station to the route, you need to select the station.'
    station_select
    puts 'Adding the station...'
    add_choice = @stations[@select_station]
    @select_route.add_sation(add_choice)
    puts 'Station was added!'
  end

  def route_station_delete
    puts 'To delete a station from the route, you need to select the station.'
    station_select
    puts 'Deleting the station...'
    delete_choice = @stations[@select_station]
    @select_route.delete_sation(delete_chice)
    puts 'Station was deleted from the route.'
  end
  #----------------------------------------------------------------------------
  #4. ROUTE ASSIGNMENT
  def route_assignment_for_train
    train_select
    route_select
    @select_train.route_assignment(@select_route)
  end
  #----------------------------------------------------------------------------
  #5. CREATE AND ADD/DELETE WAGONS
  def wagon_number
    puts 'What a number of the wagon you want to create?'
    puts 'For example -- 123 -- '
    num = gets.chomp.to_i
    @new_num = num
  end
  
  def wagon_create_by_type
    puts 'Select a type of the wagon you want to create?'
    puts "-- Type '1' for Passenger wagon."
    puts "-- Type '2' for Cargo wagon."
    type = gets.chomp.to_i
    case type
      when '1'
        if @wagons.include?(@new_num)
          puts 'Sorry, but this wagon already created.'
          train_number
        else
          @wagons.push(PassengerWagon.new(@new_num))
          puts "Wagon - #{@new_num}, was created."
        end
      when '2'
        if @wagons.include?(@new_num)
          puts 'Sorry, but this wagon already created.'
          train_number
        else
          @wagons.push(CargoWagon.new(@new_num))
          puts "Wagon - #{@new_num}, was created."
        end
    end
  end

  def add_wagon_for_train
    train_select
  end
  #----------------------------------------------------------------------------
  # 6. TRAIN MOVE FORWARD/BACK
  def train_move_back
    train_select
    @select_train.move_back
    puts "The train has moved forward to the station #{@select_train.current_station.name}."
  end

  def train_move_forward
    train_select
    @select_train.move_forward
    puts "The train has moved forward to the station #{@select_train.current_station.name}."
  end
  #----------------------------------------------------------------------------
  #7. STATIONS LIST AND TRAINS ON THE STATION LIST
  def stations
    @stations.each { |station| puts "#{station.name}, " }
  end

  def trains_on_station
    station_select
    @select_station.trains.select { |number| puts "Train: #{number}." }
  end
end
    


