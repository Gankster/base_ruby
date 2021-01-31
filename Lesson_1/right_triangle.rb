print 'Enter the first side of the triangle: '
a = gets.chomp.to_f

print 'Enter the second side of the triangle: '
b = gets.chomp.to_f

print 'Enter the third side of the triangle: '
c = gets.chomp.to_f

equilateral = a == b && a == c

return puts 'This triangle is equilateral and isosceles' if equilateral

isosceles = a == b || a == c || b == c
h = [a, b, c].max
c1, c2 = [a, b, c].min(2)

return puts 'This triangle is isosceles' if isosceles && h == c1

right = (h**2).round(2) == (c1**2 + c2**2).round(2)

if right
  puts 'This is the right triangle'
else
  puts "This is #{isosceles ? 'the isosceles' : 'not the right'} triangle"
end
