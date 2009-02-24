module Spec
  module Rails
    module Example

      class RoutingExampleGroup < ActionController::TestCase
        Spec::Example::ExampleGroupFactory.register(:routing, self)
      end

    end
  end
end