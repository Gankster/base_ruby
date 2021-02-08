# frozen_string_literal: true

class CargoCar < Car
  attr_reader :total_volume, :occupied_volume

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

  def validate!
    raise "Total volume can't be nil" if total_volume.nil?
    raise 'Total volume must be greater than 0' unless total_volume.positive?
  end
end
