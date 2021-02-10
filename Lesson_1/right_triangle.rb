# frozen_string_literal: true

print 'Enter the first side of the triangle: '
a = gets.chomp.to_f

print 'Enter the second side of the triangle: '
b = gets.chomp.to_f

print 'Enter the third side of the triangle: '
c = gets.chomp.to_f

equilateral = a == b && a == c

if equilateral
  puts 'This triangle is equilateral and isosceles'
  return
end

isosceles = a == b || a == c || b == c
h = [a, b, c].max
c1, c2 = [a, b, c].min(2)

if isosceles && h == c1
  puts 'This triangle is isosceles'
  return
end

right = (h**2).round(2) == (c1**2 + c2**2).round(2)

if right
  puts 'This is the right triangle'
else
  puts "This is #{isosceles ? 'the isosceles' : 'not the right'} triangle"
end
