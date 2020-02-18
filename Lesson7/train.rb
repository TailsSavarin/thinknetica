require_relative 'company_manufacturer'
require_relative 'instance_counter'
require_relative 'validatable'

class Train
  include CompanyManufacturer
  include InstanceCounter
  include Validatable
  attr_reader :number, :speed, :wagons, :route, :type

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/

  @@trains_number = {}

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @type = type 
    validate!
    @@trains_number[number] = self
    register_instance
  end
  
  def wagons_block
    @wagons.each { |wagon| yield(wagon) }
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

  def validate!
    validate_number_empty!
    validate_number_format!
  end

  def validate_number_empty!
    raise ArgumentError, "Number can't be empty!" if @number.empty?
  end

  def validate_number_format!
    raise ArgumentError, "Number '#{@number}' has invalid format!" if @number !~ NUMBER_FORMAT
  end

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
