# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    class_eval do
      def validations
        @validations ||= []
      end
    end

    def validate(*params)
      att, validation_type = params

      raise TypeError, 'attribute name is not symbol' unless att.is_a?(Symbol)
      raise TypeError, 'validation type is not symbol' unless validation_type.is_a?(Symbol)

      validations << params
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validations.each do |validation|
        att, validation_type, option = validation

        msg = case validation_type
              when :presence
                if instance_variable_get("@#{att}").nil? || instance_variable_get("@#{att}").empty?
                  "#{att.capitalize} can't be nil"
                end
              when :format
                "#{att.capitalize} has invalid format" if instance_variable_get("@#{att}") !~ option
              when :type
                unless instance_variable_get("@#{att}").is_a?(option)
                  "#{att.capitalize} must be a #{option} class object"
                end
              else
                "Wrong validation type: #{validation_type}"
              end

        raise msg unless msg.nil?
      end
      nil
    end
  end
end
