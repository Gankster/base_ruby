# frozen_string_literal: true

arr = (10..100).select { |e| e if (e % 5).zero? }
arr.each { |a| puts a }
