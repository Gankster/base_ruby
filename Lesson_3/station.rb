# frozen_string_literal: true

class Station
  attr_reader :trains

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

  def trains_by_type
    list_by_type = {}
    trains.each do |t|
      list_by_type[t.type] = list_by_type[t.type].to_i + 1
    end
    puts 'Number of trains per station by type'
    list_by_type.each do |type, count|
      puts "#{type}: #{count}"
    end
  end
end
