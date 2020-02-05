#Parent class for cargo_wagon & passenger_wagon
class Wagon
  attr_reader :num, :type

  def initialize(num)
    @num = num
  end
end
