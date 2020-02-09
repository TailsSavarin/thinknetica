class Route
  attr_reader :stations_list, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations_list = [first_station, last_station]
  end
  
  def add_station(station)
    stations_list.insert(-2, station) unless stations_list.include?(station)
  end

  def delete_station(station)
    stations_list.delete(station) if stations_list.include?(station)
  end
end


