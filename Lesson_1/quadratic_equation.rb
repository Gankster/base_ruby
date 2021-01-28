print "Enter the coefficient 'a': "
a = gets.chomp.to_i

print "Enter the coefficient 'b': "
b = gets.chomp.to_i

print "Enter the coefficient 'c': "
c = gets.chomp.to_i

d = b**2 - 4 * a * c

return puts "No roots. D = #{d}" if d.negative?

if d.zero?
  x = -b / (2 * a)
  puts "D = #{d}. x = #{x}"
else
  d_sqrt = Math.sqrt(d)
  x1 = (-b + d_sqrt) / (2 * a)
  x2 = (-b - d_sqrt) / (2 * a)
  puts "D = #{d}. x1 = #{x1.round(2)}, x2 = #{x2.round(2)}"
end
