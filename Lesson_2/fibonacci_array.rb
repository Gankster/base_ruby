# frozen_string_literal: true

i = 0
val = 0
fibonacci_arr = []

while val < 100
  val = if i.zero?
          0
        elsif i == 1
          1
        else
          n1, n2 = fibonacci_arr.last(2)
          n1 + n2
        end
  fibonacci_arr << val if val < 100
  i += 1
end

fibonacci_arr.each { |f| puts f }
