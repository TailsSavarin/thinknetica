require_relative 'instance_counter'
require_relative 'validatable'

class Station
  include InstanceCounter
  include Validatable

  attr_reader :name, :trains_list

  @@created_stations = []

  NAME_FORMAT = /^[a-z]{3,}$/i

  def initialize(name)
    @name = name
    @trains_list = []
    validate!
    @@created_stations.push(self)
    register_instance
  end

  def trains_block
    @trains_list.each { |train| yield(train)  }
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

  def validate!
    validate_name_empty!
    validate_name_format!
  end

  def validate_name_empty!
    raise ArgumentError, "Name can't be empty!" if @name.empty?
  end

  def validate_name_format!
    raise ArgumentError, "Name '#{@name}' has invalid format!" if @name !~ NAME_FORMAT
  end

  def trains_by_type(type)
    trains_list.select { |x| x.type == type }
  end
end

