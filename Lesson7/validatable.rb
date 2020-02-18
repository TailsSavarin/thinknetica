module Validatable
  def valid?
    validate!
    true
  rescue ArgumentError
    false 
  end
end
