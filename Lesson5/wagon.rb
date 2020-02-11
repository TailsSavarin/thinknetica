require_relative 'company_manufacturer'

class Wagon
  include CompanyManufacturer

  attr_reader :type
  
  def initialize
    @type = type 
  end
end
