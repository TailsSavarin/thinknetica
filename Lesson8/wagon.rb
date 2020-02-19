# frozen_string_literal: true

require_relative 'company_manufacturer'

class Wagon
  include CompanyManufacturer
  attr_reader :type
end
