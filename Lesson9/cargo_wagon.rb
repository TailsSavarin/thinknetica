# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :volume, :occupied_volume, :available_volume
  attr_writer :occupied_volume, :available_volume

  def initialize(volume)
    @type = 'cargo'
    @volume = volume
    @occupied_volume = 0
    @available_volume = volume
  end

  def take_volume(quantity)
    return unless quantity <= @available_volume

    self.available_volume -= quantity
    self.occupied_volume += quantity
  end
end
