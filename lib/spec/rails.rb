silence_warnings { RAILS_ENV = "test" }

begin
  require_dependency 'application_controller'
rescue MissingSourceFile
  require_dependency 'application'
end

require 'action_controller/test_process'
require 'action_controller/integration'
require 'active_record/fixtures' if defined?(ActiveRecord::Base)
require 'test/unit'

require 'spec'

require 'spec/rails/matchers'
require 'spec/rails/mocks'
require 'spec/rails/example'
require 'spec/rails/extensions'
require 'spec/rails/interop/testcase'

if Rails::VERSION::STRING >= "2.0"
  # This is a temporary hack to get rspec's auto-runner functionality to not consider
  # ActionMailer::TestCase to be a spec waiting to run.
  require 'action_mailer/test_case'
  Spec::Example::ExampleGroupFactory.register(:ignore_for_now, ActionMailer::TestCase)
end