class Station
  attr_reader :name, :trains_list

  def initialize(name)
    @name = name
    @trains_list = []
  end

  def train_arrive(number)
    if trains_list.include?(number)
      puts "This train aleady located at the station!" 
    else
      trains_list << number
      puts "Train: #{number} arrived at the #{name} station."
    end
  end

  def train_send(number)
    if trains_list.include?(number) 
      trains_list.delete(number)
      puts "Train: #{train} left the #{name} station."
    else 
      puts "This train already left the station!"
    end
  end

  def list_type(type)
    puts trains_list.select { |x| x.type == type }
  end
end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def station_add(name)
    if stations.include?(name)
      puts "Station with that name already in the list!"
    else
      stations.insert(-2, name)
      puts "Station: #{name}, was added."
    end
  end

  def station_delete(name)
    if stations.include?(name)
      stations.delete(name)
      puts "Station: #{name}, was deleted."
    else
      puts "Station with that name already deleted"
    end
  end

  def station_list
    puts stations.select(&:name).join("->")
  end
end

class Train
  attr_reader :number, :type, :sum_trains, :speed, :route, :current_station

  def initialize(number, type, sum_trains)
    @number = number
    @type = type
    @sum_trains = sum_trains
    @speed = 0
  end

  def speed_up(speed = 5)
    @speed += speed
    @speed = 90 if @speed > 90
  end

  def speed_down(speed = 5) 
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def add_train
    @sum_trains += 1 if @speed == 0
  end

  def delete_train
    @sum_trains -= 1 if @sum_trains > 0 && @speed == 0
  end

  def current_station=(station)
    current_station.train_send(self) if current_station
    @current_station = station
    station.train_arrive(self)
  end

  def route_assignment(route)
    @route = route
    self.current_station = route.stations.first
  end

  def next_station
    current_station_index = route.stations.index(current_station)
    route.stations[current_station_index + 1] if route.stations[current_station_index + 1]
  end

  def previous_station
    cureent_station_index = route.stations.index(current_station)
    route.stations[current_station_index - 1] if route.stations[current_station_index - 1]
  end

  def move_forward
    self.courrent_station = next_station
  end
  
  def move_back
    self.current_station = previous_station
  end
end

