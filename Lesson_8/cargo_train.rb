# frozen_string_literal: true

require_relative 'validation'

class CargoTrain < Train
  include Validation

  NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i.freeze
  TYPE = :cargo

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :presence

  def initialize(number)
    super(number, TYPE)
  end

  def add_car(car)
    raise 'You cannot add a new car if the train has not stopped' unless stopped?
    raise 'You can add only cassenger car' unless car.is_a?(CargoCar)

    cars << car
  end

  def delete_car
    raise 'You cannot delete the car if the train has not stopped' unless stopped?
    raise 'You can delete only cargo car' unless car.is_a?(CargoCar)

    cars.delete(car)
  end
end
