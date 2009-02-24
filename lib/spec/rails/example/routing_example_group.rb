module Spec
  module Rails
    module Example

      class RoutingExampleGroup < ActionController::TestCase
        class RoutingController < ActionController::Base
        end
        
        tests RoutingController
        
        Spec::Example::ExampleGroupFactory.register(:routing, self)
      end

    end
  end
end