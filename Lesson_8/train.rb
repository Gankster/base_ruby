# frozen_string_literal: true

require_relative 'manufacturing_company'
require_relative 'class_level_inheritable_attributes'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include InstanceCounter
  include ManufacturingCompany
  include ClassLevelInheritableAttributes
  include Validation
  include Accessors

  inheritable_attributes :trains

  attr_reader :number, :type, :route

  attr_accessor_with_history :speed

  NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :presence

  @trains = []

  class << self
    def find(number)
      trains.find { |train| train.number == number }
    end

    attr_reader :trains
  end

  def initialize(number, type)
    @number = number.to_s
    @type = type.to_sym
    @speed = 0
    @cars = []
    validate!
    self.class.trains << self
    register_instance
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
    raise ArgumentError, 'Argument must be a Route class object' unless route.is_a?(Route)

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

  def each_by_cars(&block)
    cars.each(&block)
  end

  def cars_quantity
    cars.size
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
