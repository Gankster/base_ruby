# frozen_string_literal: true

VOWELS = %w[a e i o u y].freeze

vowels_hash = {}
('a'..'z').to_a.each.with_index(1) do |l, i|
  vowels_hash[l] = i if VOWELS.include?(l)
end

puts vowels_hash
