require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains_list

  @@created_stations = []

  def initialize(name)
    @name = name
    @trains_list = []
    @@created_stations.push(self)
    register_instance
  end
  
  def self.all
    @@created_stations
  end

  def take_train(train)
    trains_list.push(train) unless trains_list.include?(train)
  end

  def send_train(train)
    trains_list.delete(train) if trains_list.include?(train)
  end

  private

  def trains_by_type(type)
    trains_list.select { |x| x.type == type }
  end
end

