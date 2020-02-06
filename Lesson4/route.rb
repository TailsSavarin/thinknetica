class Route
  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
  end
  
  def add_station(station)
    stations.insert(-2, station) unless stations.include?(station)
  end

  def delete_station(station)
    stations.delete(station) if stations.include?(station)
  end
end


