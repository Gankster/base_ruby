# frozen_string_literal: true

class PassengerCar < Car
  attr_reader :total_seats, :occupied_seats

  def initialize(total_seats)
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

  def validate!
    raise "Total seats can't be nil" if total_seats.nil?
    raise 'Total seats must be greater than 0' unless total_seats.positive?
  end
end
