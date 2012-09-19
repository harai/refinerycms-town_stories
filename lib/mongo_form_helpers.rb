module ActionView
  module Helpers
    class FormBuilder
      def mongo_fields_for(name, *args, &block)
        @template.fields_for("#{object_name}[#{name}]", object[name], *args, &block)
      end
    end
    module InstanceTagMethods
      module ClassMethods
        def value(object, method_name)
          if object.is_a?(Array)
            return object[method_name.to_i]
          end

          object.send method_name unless object.nil?
        end

        def value_before_type_cast(object, method_name)
          if object.is_a?(Array)
            return object[method_name.to_i]
          end

          unless object.nil?
            object.respond_to?(method_name + "_before_type_cast") ?
            object.send(method_name + "_before_type_cast") :
            object.send(method_name)
          end
        end
      end
    end
  end
end
