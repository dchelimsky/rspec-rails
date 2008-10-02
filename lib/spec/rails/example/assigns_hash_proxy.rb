module Spec
  module Rails
    module Example
      class AssignsHashProxy #:nodoc:
        def initialize(example_group, &block)
          @target = block.call
          @example_group = example_group
        end

        def [](ivar)
          assigns[ivar] || assigns[ivar.to_s] || @target.instance_variable_get("@#{ivar}")
        end

        def []=(ivar, val)
          @target.instance_variable_set("@#{ivar}", val)
        end

        def delete(name)
          assigns.delete(name.to_s)
        end

        def each(&block)
          assigns.each &block
        end

        def has_key?(key)
          assigns.key?(key.to_s)
        end

        protected
        def assigns
          @example_group.orig_assigns
        end
      end
    end
  end
end
