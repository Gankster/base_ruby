# frozen_string_literal: true

VOWELS = %w[a e i o u y].freeze

vowels_hash = {}
('a'..'z').to_a.each_with_index do |l, i|
  vowels_hash[l] = i + 1 if VOWELS.include?(l)
end

puts vowels_hash
