print 'Enter the base of the triangle? '
base = gets.chomp.to_f.round(2)

print 'Enter the height of the triangle? '
height = gets.chomp.to_f.round(2)

area = (0.5 * base * height).round(2)

puts "The area of the triangle is #{area}"
