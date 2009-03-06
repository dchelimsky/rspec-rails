# Upgrade to rspec-rails-1.1.99.x

## Supported Rails Versions

This release supports the following versions of rails:

* 2.0.5
* 2.1.2
* 2.2.2
* 2.3.1

## update generated files

Be sure to run "script/generate rspec" and allow the following files to be overwritten:

* lib/tasks/rspec.rake
* script/spec
* script/spec_server

## ``controller.use_rails_error_handling!`` is deprecated

Use ``rescue_action_in_public!`` instead. It comes directly from rails and does
exactly the same thing

## route_for

After a change to edge rails broke our monkey-patched ``route_for`` method, I
decided to just delegate to rails' ``assert_generates`` method. For most cases,
this will not present a problem, but for some it might. You'll know if you
upgrade and see any newly failing, route-related examples. Here are the things
that you might need to change.

### Make sure IDs are strings

If you had :id => 1 before, you need to change that to :id => "1"

	  #old
	  route_for(:controller => 'things', :action => 'show', :id => 1).should == "/things/1"
  
	  #new
	  route_for(:controller => 'things', :action => 'show', :id => "1").should == "/things/1"
  
### Convert paths for non-get methods to hashes

If you had an example with a route that requires post, put, or delete, you'll
need to declare that explicitly.

	  #old
	  route_for(:controller => 'things', :action => 'create').should == "/things"
  
	  #new
	  route_for(:controller => 'things', :action => 'create').should == {:path => "/things", :method => :post}
