# frozen_string_literal: true

public

def seed
  station1 = Station.new('TestA')
  station2 = Station.new('TestB')
  station3 = Station.new('TestC')

  route1 = Route.new(station1, station2)

  train1 = PassengerTrain.new('aaa11')
  train2 = CargoTrain.new('bbb22')

  @stations = [station1, station2, station3]
  @routes = [route1]
  @trains = [train1, train2]
end
