module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances ||= nil
      self.class.instances += 1
    end
  end
end

