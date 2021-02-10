# frozen_string_literal: true

print 'What is your name? '
name = gets.chomp.capitalize

print 'What is your height (cm)? '
height = gets.chomp.to_i

perfect_weight = (height - 110) * 1.15

if perfect_weight.negative?
  puts "#{name}, your weight is already optimal"
else
  puts "#{name}, your perfect weight: #{perfect_weight.round(1)} kg"
end
