require_relative 'company_manufacturer'
require_relative 'instance_counter'

class Train
  include CompanyManufacturer
  include InstanceCounter

  attr_reader :number, :speed, :wagons, :route, :type
  @@instances = 0
  @@trains_number = {}

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @type = type 
    @@trains_number[number] = self
    register_instance
  end
  
  def self.find(number)
    @@trains_number[number]
  end

  def add_wagon(wagon)
    wagons.push(wagon) if speed.zero? && wagon.type == self.type
  end

  def delete_wagon
    wagons.pop if speed.zero? 
  end

  def route_assignment(route)
    @route = route
    route.first_station.take_train(self)
  end

  def current_station
    @route.stations_list.each.find { |station| station.trains_list.include?(self) }
  end
  
  def next_station
    return if current_station == @route.last_station
    index_station = @route.stations_list.index(current_station) + 1
    @route.stations_list[index_station]
  end

  def previous_station
    return if current_station == @route.first_station
    index_station = @route.stations_list.index(current_station) - 1
    @route.stations_list[index_station] 
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

  private

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
end
