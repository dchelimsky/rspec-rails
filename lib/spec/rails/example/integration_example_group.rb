class ActionController::IntegrationTest
  alias_method :orig_initialize, :initialize
  def initialize(*args)
    super
  end
end

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

module Spec
  module Rails
    module Example
      class IntegrationExampleGroup < ActionController::IntegrationTest
        Spec::Example::ExampleGroupFactory.register(:integration, self)
      end
    end
  end
end
