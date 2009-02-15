# Upgrade to rspec-rails-1.1.99.x

## update generated files

Be sure to run "script/generate rspec" and allow the following files to be overwritten:

* lib/tasks/rspec.rake
* script/spec_server

## Controller Errors

Controller error handling in rspec-rails has been broken for a while, behaving
differently in different versions of rails. This is now fixed, but it might
mean you'll see some errors you weren't getting before.

The default behaviour now is to *always* raise errors, even if they are
captured with a #rescue\_from declaration. To get the rescue\_from
declarations to be recognized, you have to call use\_rails\_error\_handling! on
the controller.

## route_for

After a change to edge rails broke our monkey-patched #route_for method, I
decided to just delegate to rails' #assert_generates method. For most cases,
this will not present a problem, but for some it might. You'll know if you
upgrade and see any newly failing, route-related examples. Here are the things
that you might need to change.

* Make sure IDs are strings

If you had :id => 1 before, you need to change that to :id => "1"

	  #old
	  route_for(:controller => 'things', :action => 'show', :id => 1).should == "/things/1"
  
	  #new
	  route_for(:controller => 'things', :action => 'show', :id => "1").should == "/things/1"
  
* Convert paths for non-get methods to hashes

If you had an example with a route that requires post, put, or delete, you'll
need to declare that explicitly.

	  #old
	  route_for(:controller => 'things', :action => 'create').should == "/things"
  
	  #new
	  route_for(:controller => 'things', :action => 'create').should == {:path => "/things", :method => :post}
