# frozen_string_literal: true

class Train
  attr_reader :number, :type, :route
  attr_accessor :speed

  TYPES = %i[cargo passenger].freeze

  def initialize(number, type)
    @number = number.to_s
    @type = TYPES.include?(type.to_sym) ? type.to_sym : :passenger
    @speed = 0
    @cars = []
  end

  def stop
    self.speed = 0
  end

  def add_car
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def delete_car
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def route=(route)
    raise ArgumentError unless route.is_a?(Route)

    delete_train_from_station(current_station)
    @route = route
    @current_station = route.first_station
    add_trian_to_station(current_station)
  end

  def current_station
    @current_station ||= route&.stations&.select { |s| s.trains.include?(self) }&.first
  end

  def next_station
    return unless route
    raise 'This is the last station' if route.last_station == current_station

    route.stations[current_position + 1]
  end

  def previous_station
    return unless route
    raise 'This is the first station' if route.first_station == current_station

    route.stations[current_position - 1]
  end

  def move_to_next_station
    return unless route
    raise 'This is the last station' if route.last_station == current_station

    delete_train_from_station(current_station)
    @current_station = route.stations[current_position + 1]
    add_trian_to_station(current_station)
  end

  def move_to_previous_station
    return unless route
    raise 'This is the first station' if route.first_station == current_station

    delete_train_from_station(current_station)
    @current_station = route.stations[current_position - 1]
    add_trian_to_station(current_station)
  end

  def stopped?
    speed.zero?
  end

  protected # Also can be useful for children classes

  attr_reader :cars

  def delete_train_from_station(station)
    station&.depart(self)
  end

  def add_trian_to_station(station)
    station&.arrive(self)
  end

  def current_position
    route&.station_order(current_station)
  end
end
