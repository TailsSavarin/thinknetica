# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^[a-z]{3,}$/i.freeze

  attr_reader :name, :trains_list

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, NAME_FORMAT

  @@created_stations = []

  def self.all
    @@created_stations
  end

  def initialize(name)
    @name = name
    @trains_list = []
    validate!
    @@created_stations.push(self)
    register_instance
  end

  def trains_block
    @trains_list.each { |train| yield(train) }
  end

  def take_train(train)
    trains_list.push(train) unless trains_list.include?(train)
  end

  def send_train(train)
    trains_list.delete(train) if trains_list.include?(train)
  end

  def trains_by_type(type)
    trains_list.select { |x| x.type == type }
  end
end
