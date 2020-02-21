# frozen_string_literal: true

require_relative 'accessors'

class Colors
  include Accessors

  attr_accessor_with_history :color
  strong_attr_accessor :tint, String
end

test = Colors.new

puts 'Test started...'
test.color = 'Blue'
test.color = 'Black'
test.color = 'White'
test.color = 'Red'
p test.color_history
begin
  test.tint = 1
rescue StandardError => e
  puts e.message
end
puts 'Test complete!'
