# frozen_string_literal: true

class Bucket
  attr_reader :bucket

  def initialize
    @bucket = {}
  end

  def run
    name = ''
    while name != 'stop'
      print 'Enter the name of the product, or to summarize, enter "stop": '
      name = gets.chomp

      print 'Enter product price: '
      price = gets.chomp.to_f.round(2)

      print 'Enter the quantity of products: '
      quantity = gets.chomp.to_f.round(2)

      bucket[name] = { price: price, quantity: quantity }
    end
    show_summary
  end

  def show_summary
    total_amount = 0.0
    puts '============================'
    puts bucket
    puts '============================'
    bucket.each do |name, data|
      sum = (data[:price] * data[:quantity]).round(2)
      total_amount += sum
      puts "#{name}: #{sum}"
    end
    puts '============================'
    puts "Total: #{total_amount}"
    puts '============================'
  end
end

Bucket.new.run
