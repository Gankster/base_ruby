# frozen_string_literal: true

require_relative 'validation'

class PassengerTrain < Train
  include Validation

  NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i.freeze
  TYPE = :passenger

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :presence

  def initialize(number)
    super(number, TYPE)
  end

  def add_car(car)
    raise 'You cannot add a new car if the train has not stopped' unless stopped?
    raise 'You can add only passenger car' unless car.is_a?(PassengerCar)

    cars << car
  end

  def delete_car
    raise 'You cannot delete the car if the train has not stopped' unless stopped?

    cars.pop
  end
end
