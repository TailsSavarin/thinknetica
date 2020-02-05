class CargoWagon < Wagon
  def initialize(num)
    super(num)
    @type = 'cargo'
  end
end

