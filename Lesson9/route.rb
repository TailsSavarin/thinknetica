# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations_list, :first_station, :last_station

  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations_list = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    stations_list.insert(-2, station) unless stations_list.include?(station)
  end

  def delete_station(station)
    stations_list.delete(station) if stations_list.include?(station)
  end
end
