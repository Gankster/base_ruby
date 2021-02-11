# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        raise TypeError, 'method name is not symbol' unless method.is_a?(Symbol)

        define_method("#{method}_history") do
          instance_variable_get("@#{method}_history") || instance_variable_set("@#{method}_history", [])
        end

        define_method(method) do
          instance_variable_get("@#{method}")
        end

        define_method("#{method}=") do |v|
          instance_variable_set("@#{method}", v)
          instance_variable_get("@#{method}_history") << v
        end
      end
    end

    def strong_attr_accessor(*methods)
      raise ArgumentError, 'method expects two arguments' if methods.size != 2

      method, klass = methods

      raise TypeError, 'method name is not symbol' unless method.is_a?(Symbol)

      define_method(method) do
        instance_variable_get("@#{method}")
      end

      define_method("#{method}=") do |v|
        raise TypeError, "value is not #{klass}" unless v.is_a?(klass)

        instance_variable_set("@#{method}", v)
      end
    end
  end
end
