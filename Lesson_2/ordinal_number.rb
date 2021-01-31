# frozen_string_literal: true

class OrdinalNumber
  MONTHS = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].freeze

  attr_reader :day, :month, :year

  def initialize(date)
    validate_date(date)
    @day, @month, @year = date
  end

  def self.run
    print 'Enter the day, month and year (for example: 30-1-2021): '
    date = gets.chomp.split('-').map(&:to_i)
    new(date).calculate_ordinal_number
  end

  def validate_date(date)
    return puts 'Invalid date' unless date.is_a?(Array)
    return puts 'You must enter three numbers' unless date.size == 3
    return puts 'The day value is incorrect' unless (1..31).include?(date[0])
    return puts 'The month value is incorrect' unless (1..12).include?(date[1])
    return puts 'The year value is incorrect' unless date[2].positive?
  end

  def calculate_ordinal_number
    days = MONTHS.slice(0, month - 1).sum
    result = days + day
    result += 1 if leap? && month > 2
    puts result
  end

  def leap?
    con1 = (year % 4).zero? && !(year % 100).zero?
    con2 = (year % 4).zero? && (year % 400).zero? && (year % 100).zero?
    con1 || con2
  end
end

OrdinalNumber.run
