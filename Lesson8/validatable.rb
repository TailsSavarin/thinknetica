# frozen_string_literal: true

module Validatable
  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end
