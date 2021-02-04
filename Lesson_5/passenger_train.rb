# frozen_string_literal: true

class PassengerTrain < Train
  TYPE = :passenger

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
