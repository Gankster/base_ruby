# frozen_string_literal: true

require_relative 'validation'

class CargoCar < Car
  include Validation

  attr_reader :total_volume, :occupied_volume

  validate :total_volume, :presence

  def initialize(total_volume)
    @total_volume = total_volume || 0
    @occupied_volume = 0
    validate!
  end

  def fill_volume(volume)
    raise 'No free space to fill' unless available_volume > volume

    self.occupied_volume += volume
  end

  def available_volume
    total_volume - occupied_volume
  end

  private

  attr_writer :occupied_volume
end
