class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end
  
  #Trains list, sort by type
  def trains_by_type(type)
    trains.select { |x| x.type == type }
  end

  #User cannot manipulate trains from the station
  private

  def take_train(train)
    trains.push(train) unless trains.include?(train)
  end

  def send_train(train)
    trains.delete(train) if trains.include?(train)
  end
end


