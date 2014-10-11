require "callsite"
require "pp"

module Smartargs
  module Mixin
    # [[:req, :x], [:req, :y]]
    # [[:req, :x], [:rest, :y]]

    def sub(types, name)
      method     = self.instance_method(name)
      parameters = method.parameters

      self.class_eval do
        define_method(name) do |*args|
          args.each.with_index do |v, i|
            parameters[i] or raise ArgumentError, "maybe too many"
            types[i]      or raise ArgumentError, "undefined argument type"

            if !v.kind_of?(types[i])
              raise ArgumentError, "missmatch class"
            end
          end
          method.bind(self).call(*args)
        end
      end
    end
  end
end
