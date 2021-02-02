# frozen_string_literal: true

class Route
  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_of_station = []
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
end
