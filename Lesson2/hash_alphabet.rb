# frozen_string_literal: true

vowels_hash = {}
alphabet = ('a'..'z').to_a
vowels = %w[a e i o u y]
vowels.each { |vowel| vowels_hash[vowel] = alphabet.index(vowel) + 1 }
puts 'Letter - number'
vowels_hash.each { |x, y| puts "#{x} - #{y}" }
