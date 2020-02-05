class CargoTrain < Train
  def initialize(number)
    super(number)
    @type = 'cargo'
  end

  def add_wagon(wagon)
    super(wagon)
  end
end

