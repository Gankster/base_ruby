# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  validate :name, :presence
  validate :name, :type, String

  @stations = []

  class << self
    def all
      @stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.all << self
    register_instance
  end

  def arrive(train)
    raise ArgumentError unless train.is_a?(Train)

    trains << train
  end

  def depart(train)
    raise ArgumentError unless train.is_a?(Train)

    trains.delete(train)
  end

  def trains_by_type(type)
    trains_by_type = trains.select { |t| t.type == type.to_sym }
    puts 'Number of trains per station by type'
    puts "#{type}: #{trains_by_type.size}"
  end

  def each_by_trains(&block)
    trains.each(&block)
  end
end
