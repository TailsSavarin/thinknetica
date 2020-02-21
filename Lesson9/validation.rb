# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *args)
      @validations ||= []
      @validations << { name: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}")
        send("validate_#{validation[:type]}", value, *validation[:args])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(value)
      return unless value.to_s.empty?

      raise ArgumentError, 'Attribute value cannot be empty!'
    end

    def validate_format(value, format)
      return unless value !~ format

      raise ArgumentError, 'Attribute value is invalid format!'
    end

    def validate_type(value, type)
      raise ArgumentError, 'Attribute value is invalid type!' unless value.is_a?(type)
    end
  end
end
