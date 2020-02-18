require_relative 'wagon'

class PassengerWagon < Wagon

  attr_reader :seats, :taken_seats, :free_seats
  attr_writer :taken_seats, :free_seats

  def initialize(seats)
    @type = 'passenger'
    @seats = seats
    @taken_seats = 0
    @free_seats = seats
  end
  
  def take_seat
    return unless @free_seats > 0
    self.free_seats -= 1
    self.taken_seats += 1
  end
end

