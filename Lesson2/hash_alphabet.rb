vowels = %w{a e i o u y}
alphabet = ('a'..'z').to_a
vowels_letter = {}
vowels.each do |vowel| 
  vowels_letter[vowel] = alphabet.index(vowel) + 1 
end
puts vowels_letter


