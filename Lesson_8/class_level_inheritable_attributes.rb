# frozen_string_literal: true

module ClassLevelInheritableAttributes
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def inheritable_attributes(*args)
      @inheritable_attributes ||= [:inheritable_attributes]
      @inheritable_attributes += args
      args.each do |arg|
        class_eval <<-STR, __FILE__, __LINE__ + 1
          class << self               # class << self
            attr_accessor :#{arg}     #   attr_accessor :trains
          end                         # end
        STR
      end
      @inheritable_attributes
    end

    def inherited(subclass)
      super
      @inheritable_attributes.each do |inheritable_attribute|
        instance_var = "@#{inheritable_attribute}"
        subclass.instance_variable_set(instance_var, instance_variable_get(instance_var))
      end
    end
  end
end
