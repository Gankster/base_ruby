# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_of_station = []
    register_instance
    validate!
  end

  def add(station)
    list_of_station << station
  end

  def delete(station)
    list_of_station.delete(station)
  end

  def stations
    [first_station, *list_of_station, last_station]
  end

  def station_order(station)
    stations.index(station)
  end

  private

  attr_reader :list_of_station

  def validate!
    raise "First station can't be nil" if first_station.nil?
    raise 'First station must be a Station class object' unless first_station.is_a?(Station)
    raise "Last station can't be nil" if last_station.nil?
    raise 'Last station must be a Station class object' unless last_station.is_a?(Station)
  end
end
