# frozen_string_literal: true

i = 0
fibonacci_arr = []
loop do
  val = if i.zero?
          0
        elsif i == 1
          1
        else
          n1, n2 = fibonacci_arr.last(2)
          n1 + n2
        end

  break if val > 100

  fibonacci_arr << val
  i += 1
end

fibonacci_arr.each { |f| puts f }
