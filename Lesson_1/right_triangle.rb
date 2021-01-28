print 'Enter the first side of the triangle: '
a = gets.chomp.to_i

print 'Enter the second side of the triangle: '
b = gets.chomp.to_i

print 'Enter the third side of the triangle: '
c = gets.chomp.to_i

equilateral = a == b && a == c

return puts 'This triangle is equilateral and isosceles' if equilateral

isosceles = a == b || a == c || b == c
sides = [a, b, c].sort { |i, j| j <=> i }

return puts 'This triangle is isosceles' if isosceles && sides[0] == sides[1]

right = sides[0]**2 == (sides[1]**2 + sides[2]**2)

if right
  puts 'This is the right triangle'
else
  puts "This is #{isosceles ? 'the isosceles' : 'not the right'} triangle"
end
