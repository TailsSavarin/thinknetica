module Validatable
  def valid?
    validate!
    true
  rescue
    false
  end
end
