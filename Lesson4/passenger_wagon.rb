class PassangerWagon < Wagon
  def initialize(num)
    super(num)
    @type = 'passenger'
  end

  def passenger_wagon?
    true
  end
end

