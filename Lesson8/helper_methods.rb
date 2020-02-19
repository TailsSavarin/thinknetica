# frozen_string_literal: true

MAIN_MENU = "
---------------    Control  Panel     ---------------\n
---------------       Type '1'        ---------------
--------------- #Stations management# ---------------\n
---------------       Type '2'        ---------------
---------------  #Trains management#  ---------------\n
---------------       Type '3'        ---------------
---------------  #Routes management#  ---------------\n
---------------       Type '0'        ---------------
---------------         Exit          ---------------\n"

STATIONS_MENU = "
- Type '1' to create a station ----------------------\n
- Type '2' to view the list of stations -------------\n
- Type '3' to view the list of trains at the stations\n
- Type '4' to view list of wagons at the station ----\n
- Type '0' to return to the main menu ---------------\n "

TRAINS_MENU = "
- Type '1' to create a train ------------------------\n
- Type '2' to move train front ----------------------\n
- Type '3' to move train back -----------------------\n
- Type '4' to add wagons to the train ---------------\n
- Type '5' to delete wagons from the train ----------\n
- Type '6' to actions with he volume of wagons ------\n
- Type '0' to return to the main menu ---------------\n "

ROUTES_MENU = "
- Type '1' to create a route ------------------------\n
- Type '2' to add or delete station in route --------\n
- Type '3' to assign a train route ------------------\n
- Type '0' to return to the main menu ---------------\n "

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
