# frozen_string_literal: true

class CargoTrain < Train
  TYPE = :cargo

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
