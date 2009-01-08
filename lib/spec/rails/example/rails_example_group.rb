require 'spec/interop/test'

if ActionView::Base.respond_to?(:cache_template_extension)
  ActionView::Base.cache_template_extensions = false
end

module Spec
  module Rails
    module Example
      class RailsExampleGroup < ActiveSupport::TestCase
        include ActionController::Assertions::SelectorAssertions
        include Spec::Rails::Matchers
        include Spec::Rails::Mocks
        Spec::Example::ExampleGroupFactory.default(self)
      end
    end
  end
end
