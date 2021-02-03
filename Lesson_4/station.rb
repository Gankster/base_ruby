# frozen_string_literal: true

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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
end
