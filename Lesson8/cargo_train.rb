# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number)
    super(number)
    @type = 'cargo'
  end
end
