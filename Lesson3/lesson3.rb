class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    trains.push(train) unless trains.include?(train)
  end

  def send_train(train)
    trains.delete(train) if trains.include?(train)
  end

  def list_type(type)
    trains.select { |x| x.type == type }
  end
end

class Route
  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
  end

  def add_station(station)
    stations.insert(-2, station) unless stations.include?(station)
  end

  def delete_station(station)
    stations.delete(station) if stations.include?(station)
  end
end

class Train
  attr_reader :number, :type, :count, :speed, :route

  def initialize(number, type, count)
    @number = number
    @type = type
    @count = count
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
    @count += 1 if @speed.zero?
  end

  def delete_train
    @count -= 1 if @count > 0 && @speed.zero?
  end

  def route_assignment(route)
    @route = route
    route.first_station.take_train(self)
  end

  def current_station
    @route.stations.each.find { |station| station.trains.include?(self) }
  end
  
  def next_station
    return unless current_station != @route.last_station
    index_station = @route.stations.index(current_station) + 1
    @route.stations[index_station]
  end

  def previous_station
    return unless current_station != @route.first_station
    index_station = @route.stations.index(current_station) - 1
    @route.stations[index_station] 
  end

  def move_forward
    return unless next_station
    station = next_station
    current_station.send_train(self)
    station.take_train(self)
  end

  def move_back 
    return unless previous_station
    station = previous_station
    current_station.send_train(self)
    station.take_train(self)
  end
end
