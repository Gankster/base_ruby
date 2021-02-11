# frozen_string_literal: true

require_relative 'validation'
require_relative 'accessors'

class PassengerCar < Car
  include Validation
  include Accessors

  attr_reader :occupied_seats

  strong_attr_accessor :total_seats, Integer

  validate :total_seats, :presence

  def initialize(total_seats)
    super
    @total_seats = total_seats || 0
    @occupied_seats = 0
    validate!
  end

  def take_seat_of
    raise 'There are no empty seats in the train car' unless available_seats.positive?

    self.occupied_seats += 1
  end

  def available_seats
    total_seats - occupied_seats
  end

  private

  attr_writer :occupied_seats
end
