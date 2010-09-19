require 'spec_helper'
require 'controller_spec_controller'
require File.join(File.dirname(__FILE__), "/shared_routing_example_group_examples.rb")

describe "Routing Examples", :type => :routing do
  it_should_behave_like "a routing example"
  it_should_behave_like "a be routable spec"
  it_should_behave_like "a route to spec"
end
