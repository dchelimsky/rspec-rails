class CustomRouteSpecController < ActionController::Base; end
class RspecOnRailsSpecsController < ActionController::Base; end

share_as :RoutingExampleGroupSpec do
  describe "backward compatible route_for()" do
    it "translates GET-only paths to be explicit" do
      should_receive(:assert_routing).with(hash_including(:method => :get), anything, {}, anything)
      route_for(:controller => "controller_spec", :action => "some_action").
        should == "/controller_spec/some_action"
    end

    it "asserts, using assert_routing, that the :controller and :action are involved" do
      @route = { :controller => "controller_spec", :action => "some_action" }
      should_receive(:assert_routing).with(anything, @route, {}, anything)
      route_for(@route).
        should == "/controller_spec/some_action"
    end
    it "sends extra args through" do
      @route = { :controller => "controller_spec", :action => "some_action" }
      should_receive(:assert_routing).with(anything, anything, {}, { :a => "1", :b => "2" } )
      route_for(@route).
        should == "/controller_spec/some_action?a=1&b=2"
    end
  
    it "support existing routes" do
      route_for(:controller => "controller_spec", :action => "some_action").
        should == "/controller_spec/some_action"
    end

    it "support routes with additional parameters" do
      route_for(:controller => "controller_spec", :action => "some_action", :param => '1').
        should == "/controller_spec/some_action?param=1"
    end
  
    it "recognize routes with methods besides :get" do
      should_receive(:assert_routing).with(hash_including(:method => :put), anything, {},  anything)
    
      route_for(:controller => "rspec_on_rails_specs", :action => "update", :id => "37").
        should == {:path => "/rspec_on_rails_specs/37", :method => :put}
    end
  
    it "on unexpected fail due to bad path, raise routing error, and suggest should_not be_routeable()" do
      lambda {
        route_for(:controller => "rspec_on_rails_specs", :action => "nonexistent", :id => "37") == 
          {:path => "/rspec_on_rails_specs/bad_route/37", :method => :put}
      }.should raise_error( ActionController::RoutingError, /suggest.*should_not be_routable/ )
    end
    it "on unexpected fail due to params mismatch, raise assertion, and suggest should_not be_routeable()" do
      lambda {
        route_for(:controller => "rspec_on_rails_specs", :action => "nonexistent", :id => "37") == 
          {:path => "/rspec_on_rails_specs/37", :method => :put}
      }.should raise_error( Test::Unit::AssertionFailedError, /suggest.*should_not be_routable/ )
    end
    it "on unexpected fail due to wrong HTTP method, raise the method error and suggest should_not be_routable() " do
      lambda {
        route_for(:controller => "rspec_on_rails_specs", :action => "update", :id => "37").
          should == {:path => "/rspec_on_rails_specs/37", :method => :post}
      }.should raise_error(ActionController::MethodNotAllowed) { |error| error.should_not =~ /should_not be_routable/ }
    end
  
    it "generate params for custom routes" do
      # redundant, deprecated
      params_from(:get, '/custom_route').
        should == {:controller => "custom_route_spec", :action => "custom_route"}
    end

    it "generate params for existing routes" do
      # redundant, deprecated
      params_from(:get, '/controller_spec/some_action').
        should == {:controller => "controller_spec", :action => "some_action"}
    end

    it "generate params for an existing route with a query parameter" do
      # redundant, deprecated
      params_from(:get, '/controller_spec/some_action?param=1').
        should == {:controller => "controller_spec", :action => "some_action", :param => '1'}
    end

    it "generate params for an existing route with multiple query parameters" do
      # redundant, deprecated
      params_from(:get, '/controller_spec/some_action?param1=1&param2=2').
        should == {:controller => "controller_spec", :action => "some_action", :param1 => '1', :param2 => '2' }
    end
  end
end

share_as :BeRoutableExampleGroupSpec do
  it "test should_not be_routable" do
    { :put => "/rspec_on_rails_specs/bad_route/37" }.
      should_not be_routable
  end
  it "test should be_routable" do
    { :get => "/custom_route" }.
      should be_routable
  end
    
  it "failure from should, should recommend route_to()" do
    lambda {
      { :get => "/nonexisting_route" }.
        should be_routable
    }.should raise_error( /route_to\(/)
  end

  it "failure from should_not, should show actual route that was generated" do
    lambda {
      { :get => "/custom_route" }.
        should_not be_routable
    }.should raise_error( /"action"=>"custom_route", "controller"=>"custom_route_spec"/ )
  end
  
  it "test spelling error: should_not be_routeable" do
    { :put => "/rspec_on_rails_specs/bad_route/37" }.
      should_not be_routeable
  end
  
end

share_as :RouteToExampleGroupSpec do
  it "support existing routes" do
    { :get => "/controller_spec/some_action" }.
      should route_to( :controller => "controller_spec", :action => "some_action" )
  end
     
  it "translates GET-only paths to be explicit, when matching against a string (for parity with route_for().should == '/path')" do
    should_receive(:assert_routing).with(hash_including(:method => :get), anything, {}, anything)
    "/controller_spec/some_action".
      should route_to({})
  end

  it "asserts, using assert_routing, that the :controller and :action are involved" do
    @route = { :controller => "controller_spec", :action => "some_action" }
    should_receive(:assert_routing).with(anything, @route, {}, anything)
    "/controller_spec/some_action".
      should route_to(@route)
  end
  it "sends extra args through" do
    @route = { :controller => "controller_spec", :action => "some_action" }
    should_receive(:assert_routing).with(anything, anything, {}, { :a => "1", :b => "2" } )
    "/controller_spec/some_action?a=1&b=2".
      should route_to( @route )
  end

  it "support routes with additional parameters" do
    { :get => "/controller_spec/some_action?param=1" }.
      should route_to( :controller => "controller_spec", :action => "some_action", :param => '1' )
  end
  
  it "recognizing routes with methods besides :get" do
    should_receive(:assert_routing).with(hash_including(:method => :put), anything, {}, anything)
    { :put => "/rspec_on_rails_specs/37" }.
      should route_to(:controller => "rspec_on_rails_specs", :action => "update", :id => "37")
  end
  
  it "allows only one key/value in the path - :method => path" do
    lambda {
      { :a => "b" ,:c => "d" }.
        should route_to("anything")
    }.should raise_error( ArgumentError, /usage/ )
  end
  
  it "on unexpected fail due to bad path, raise routing error, and suggest should_not be_routeable()" do
    lambda {
      { :put => "/rspec_on_rails_specs/nonexistent/37" }.
        should route_to(:controller => "rspec_on_rails_specs", :action => "nonexistent", :id => "37")
        
    }.should raise_error( ActionController::RoutingError, /suggest.*nonexistent.*should_not be_routable/ )
  end
  it "on unexpected fail due to params mismatch, raise assertion, and suggest should_not be_routeable()" do
    lambda {
      { :put => "/rspec_on_rails_specs/37" }.
        should route_to(:controller => "rspec_on_rails_specs", :action => "nonexistent", :id => "37")
    }.should raise_error( Test::Unit::AssertionFailedError, /suggest.*rspec_on_rails_specs\/37.*should_not be_routable/ )
  end

  it "when an expected failure passes instead, suggest should_not be_routable" do
    stub!(:assert_routing).and_return true
    lambda {
      { :put => "/rspec_on_rails_specs/37" }.
        should_not route_to(:controller => "rspec_on_rails_specs", :action => "update", :id => "37")
    }.should raise_error( /expected a routing error.*be_routable/im )
    
  end

  it "on unexpected fail due to wrong HTTP method, raise the method error and suggest should_not be_routable()" do
    stub!(:assert_routing).and_return do
      raise ActionController::MethodNotAllowed
    end
    lambda {
      { :post => "/rspec_on_rails_specs/37" }.
        should route_to(:controller => "rspec_on_rails_specs", :action => "update", :id => "37" )
    }.should raise_error(ActionController::MethodNotAllowed, /rspec_on_rails_specs\/37.*should_not be_routable/ )
  end
  
  
end