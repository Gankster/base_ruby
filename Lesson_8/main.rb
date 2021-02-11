# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'passenger_car'
require_relative 'cargo_car'
require 'securerandom'

class Main
  MAIN_MENU = %{
  Choose one of the options:
    1: Create a station
    2: Create a train
    3: Create a route and manage stations in it (add, delete)
    4: Assign a route to the train
    5: Add a car to the train
    6: Disconnect the car from the train
    7: Fill the car
    8: Move the train forward and backward along the route
    9: View station list and train list at station
    0: Exit
  }

  MAIN_ACTIONS = {
    1 => :create_station,
    2 => :create_train,
    3 => :create_and_manage_route,
    4 => :assign_route,
    5 => :add_car,
    6 => :disconnect_car,
    7 => :fill_car,
    8 => :move_train,
    9 => :view_station_list_and_train_list,
    0 => :stop_app
  }.freeze

  CREATE_TRAIN = %(
  Enter the number of train and type (1: Passenger, 2: Cargo) (for exsample: 3s3-d1 1):
  )

  CREATE_AND_MANAGE_ROUTE_MENU = %(
  Choose one of the options:
    1: Create a route
    2: Add station to route
    3: Delete station from route
    0: Back
  )

  CREATE_AND_MANAGE_ROUTE_ACTIONS = {
    1 => :create_route,
    2 => :add_station,
    3 => :delete_station
  }.freeze

  MOVE_TRAIN_MENU = %(
    Choose one of the options:
      1: Move to next  station
      2: Move to previous station
      0: Back
    )

  VIEW_MENU = %(
    Choose one of the options:
      1: View station list
      2: View station list with trains
      3: View train list
      4: View car list
      0: Back
    )

  def initialize
    @stop = false
    @stations = []
    @routes = []
    @trains = []
  end

  def run
    until stop
      puts MAIN_MENU
      option = gets.chomp.to_i
      choose_action(option)
    end
  end

  private

  attr_accessor :stop
  attr_reader :stations, :routes, :trains

  def choose_action(option)
    action = MAIN_ACTIONS[option]
    raise 'Wrong option' if action.nil?

    send(action)
  end

  def stop_app
    self.stop = true
  end

  def create_station
    puts 'Enter the name of the station: '
    name = gets.chomp
    stations << Station.new(name)
    puts 'Done!'
  end

  def create_train
    puts CREATE_TRAIN
    number, type = gets.chomp.split

    train = case type.to_i
            when 1
              PassengerTrain.new(number)
            when 2
              CargoTrain.new(number)
            else
              raise 'Wrong option of type'
            end
    trains << train
    puts "Train with number '#{train.number}' and type '#{train.type}' was created"
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_and_manage_route
    puts CREATE_AND_MANAGE_ROUTE_MENU
    option = gets.chomp.to_i
    create_and_manage_route_actions(option)
  end

  def create_and_manage_route_actions(option)
    action = CREATE_AND_MANAGE_ROUTE_ACTIONS[option]
    ruturn if action.nil? && option.zero?
    raise 'Wrong option' if action.nil?

    send(action)
  end

  def create_route
    puts 'Enter the first and the last stations from the list (for exsample: 1 2): '
    station_list
    first, last = gets.chomp.split.map { |i| i.to_i - 1 }
    routes << Route.new(stations[first], stations[last])
    puts 'Done!'
  end

  def add_station
    route = select_route

    puts 'Enter the station from the list (for exsample: 1): '
    station_list
    station_index = gets.chomp.to_i - 1

    route.add(stations[station_index])
    puts 'Done!'
  end

  def delete_station
    route = select_route

    puts 'Enter the station from the list (for exsample: 1): '
    list_of_stations_on_route(route.stations)
    station_index = gets.chomp.to_i - 1

    route.delete(route.stations[station_index])
    puts 'Done!'
  end

  def assign_route
    train = select_train
    route = select_route
    train.route = route
    puts 'Done!'
  end

  def add_car
    train = select_train
    car = create_car(train.type)
    train.add_car(car)
    puts 'Done!'
  end

  def disconnect_car
    train = select_train
    train.delete_car
    puts 'Done!'
  end

  def fill_car
    train = select_train
    car = select_car(train)
    case train.type
    when PassengerTrain::TYPE
      car.take_seat_of
    when CargoTrain::TYPE
      puts 'Enter the volume (for exsample: 10): '
      volume = gets.chomp.to_f.round(2)
      car.fill_volume(volume)
    else
      raise 'Wrong type of train'
    end
    puts 'Done!'
  end

  def move_train
    train = select_train
    puts MOVE_TRAIN_MENU
    action = gets.chomp.to_i
    move_train_actions(train, action)
  end

  def move_train_actions(train, action)
    case action
    when 1
      train.move_to_next_station
    when 2
      train.move_to_previous_station
    when 0
      nil
    else
      raise 'Wrong option'
    end
    puts 'Done!' if [1, 2].include?(action)
  end

  def view_station_list_and_train_list
    puts VIEW_MENU
    action = gets.chomp.to_i
    view_actions(action)
  end

  def view_actions(action)
    case action
    when 1
      station_list
    when 2
      station_list_with_trains
    when 3
      train_list_at_station(select_station)
    when 4
      car_list(select_train)
    when 0
      nil
    else
      puts 'Wrong option'
    end
    puts 'Done!'
  end

  def select_station
    puts 'Enter the station from the list (for exsample: 1): '
    station_list
    station_index = gets.chomp.to_i - 1
    stations[station_index]
  end

  def select_route
    puts 'Enter the route from the list (for exsample: 1): '
    route_list
    route_index = gets.chomp.to_i - 1
    routes[route_index]
  end

  def select_train
    puts 'Enter the train from the list (for exsample: 1): '
    train_list
    train_index = gets.chomp.to_i - 1
    trains[train_index]
  end

  def select_car(train)
    puts 'Enter the car from the list (for exsample: 1): '
    cars = car_list(train)
    car_index = gets.chomp.to_i - 1
    cars[car_index]
  end

  def create_car(type)
    case type
    when PassengerTrain::TYPE
      puts 'Enter the total seats: '
      total_seats = gets.chomp.to_i
      PassengerCar.new(total_seats)
    when CargoTrain::TYPE
      puts 'Enter the total volume: '
      total_volume = gets.chomp.to_i
      CargoCar.new(total_volume)
    else
      puts 'Wrong type of train'
    end
  end

  def station_list
    list_of_stations(stations)
  end

  def list_of_stations_on_route(stations)
    list_of_stations(stations)
  end

  def list_of_stations(stations)
    stations.each.with_index(1) { |station, i| puts "#{i}: #{station.name}" }
  end

  def station_list_with_trains
    stations.each.with_index(1) do |station, i|
      puts "#{i}: #{station.name}"
      station.each_by_trains do |train|
        puts "  Train: #{train.number}, type: #{train.type}, cars quantity: #{train.cars_quantity}"
      end
    end
  end

  def train_list
    list_of_trains(trains)
  end

  def train_list_at_station(station)
    station.trains.each.with_index(1) do |train, i|
      puts "#{i}: Train: #{train.number}, type: #{train.type}"
      train.each_by_cars do |car|
        car_property = train.type == :cargo ? 'volume' : 'seats'
        available = car.send("available_#{car_property}")
        occupied = car.send("occupied_#{car_property}")
        puts "  Car: #{SecureRandom.hex(5)}, type: #{train.type}, \
              quantity of available #{car_property}: #{available}, \
              quantity of occupied #{car_property}: #{occupied}"
      end
    end
  end

  def list_of_trains(trains)
    trains.each.with_index(1) { |train, i| puts "#{i}: Train - number: #{train.number} and type: #{train.type}" }
  end

  def car_list(train)
    cars = []
    index = 1
    train.each_by_cars do |car|
      car_property = train.type == :cargo ? 'volume' : 'seats'
      available = car.send("available_#{car_property}")
      occupied = car.send("occupied_#{car_property}")
      puts "#{index}) Car: #{SecureRandom.hex(5)}, type: #{train.type}, \
            quantity of available #{car_property}: #{available}, \
            quantity of occupied #{car_property}: #{occupied}"

      cars << car
      index += 1
    end
    cars
  end

  def route_list
    routes.each.with_index(1) { |route, i| puts "#{i}: from #{route.first_station.name} to #{route.last_station.name}" }
  end
end

m = Main.new
m.run
