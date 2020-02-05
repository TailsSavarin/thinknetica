#It's parent class for passenger_train and cargo_train
class Train
  attr_reader :number, :speed, :wagons, :route, :type

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
  end
  
  #Speed methods
  def speed_up(speed = 5)
    @speed += speed
    @speed = 90 if @speed > 90
  end

  def speed_down(speed = 5) 
    @speed -= speed
    @speed = 0 if @speed < 0
  end
  
  def emergency_brake
    @speed = 0
  end

  #Wagon methods
  def add_wagon(wagon)
    wagons.push(wagon) if speed.zero?
  end

  def delete_wagon(wagon)
    wagons.delete(wagon) if speed.zero? && wagons.include?(wagon)
  end

  #Route assignment, main thing
  def route_assignment(route)
    @route = route
    route.first_station.take_train(self)
  end

  #Visual actions with stations
  def current_station
    @route.stations.each.find { |station| station.trains.include?(self) }
  end
  
  def next_station
    return if current_station == @route.last_station
    index_station = @route.stations.index(current_station) + 1
    @route.stations[index_station]
  end

  def previous_station
    return if current_station == @route.first_station
    index_station = @route.stations.index(current_station) - 1
    @route.stations[index_station] 
  end

  #Physical activities with stations
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
