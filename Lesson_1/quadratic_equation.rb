# frozen_string_literal: true

print "Enter the coefficient 'a': "
a = gets.chomp.to_f

print "Enter the coefficient 'b': "
b = gets.chomp.to_f

print "Enter the coefficient 'c': "
c = gets.chomp.to_f

d = (b**2 - 4 * a * c).round(2)

if d.negative?
  puts "No roots. D = #{d}"
  return
end

if d.zero?
  x = (-b / (2 * a)).round(2)
  puts "D = #{d}. x1=x2 = #{x}"
else
  d_sqrt = Math.sqrt(d)
  x1 = ((-b + d_sqrt) / (2 * a)).round(2)
  x2 = ((-b - d_sqrt) / (2 * a)).round(2)
  puts "D = #{d}. x1 = #{x1}, x2 = #{x2}"
end
