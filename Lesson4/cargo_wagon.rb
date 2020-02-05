class CargoWagon < Wagon
  def initialize(num)
    super(num)
    @type = 'cargo'
  end

  def cargo_wagon?
    true
  end
end

