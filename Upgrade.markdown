# Upgrade to rspec-rails-1.1.99.x (pre rspec-rails-1.2)

## What's changed

### Supported Rails Versions

This release supports the following versions of rails:

* 2.0.5
* 2.1.2
* 2.2.2
* 2.3.1

### update generated files

Be sure to run "script/generate rspec" and allow the following files to be overwritten:

* lib/tasks/rspec.rake
* script/spec
* script/spec_server

### ``controller.use_rails_error_handling!`` is deprecated

Use ``rescue_action_in_public!`` instead. It comes directly from rails and does
exactly the same thing

### route_for

After a change to edge rails broke our monkey-patched ``route_for`` method, I
decided to just delegate to rails' ``assert_generates`` method. For most cases,
this will not present a problem, but for some it might. You'll know if you
upgrade and see any newly failing, route-related examples. Here are the things
that you might need to change.

#### Make sure IDs are strings

If you had :id => 1 before, you need to change that to :id => "1"

    #old
    route_for(:controller => 'things', :action => 'show', :id => 1).should == "/things/1"
  
    #new
    route_for(:controller => 'things', :action => 'show', :id => "1").should == "/things/1"
  
#### Convert paths for non-get methods to hashes

If you had an example with a route that requires post, put, or delete, you'll
need to declare that explicitly.

    #old
    route_for(:controller => 'things', :action => 'create').should == "/things"
  
    #new
    route_for(:controller => 'things', :action => 'create').should == {:path => "/things", :method => :post}
  
### Controller/template isolation

Even though controller specs do not render views by default (use
``integrate_views`` to get them to render views), the way this works has
changed in this version.

It used to be that the view template need not even exist, but due to changes
in rails it became much more difficult to manage that for all the different
versions of rails that rspec-rails supports. So now the template must exist,
but it still won't be rendered unless you declare ``integrate_views``.

## What's new

### render no longer requires a path

The ``render()`` method in view specs will infer the path from the
first argument passed to ``describe()``.

    describe "players/show" do
      it "does something" do
        render
        response.should have_tag("....")
      end
    end
    
### routing specs live in spec/routing

``script/generate rspec_scaffold`` now generates its routing spec in
``spec/routing/``.

### bypass_rescue

Added a new ``bypass_rescue()`` declaration for controller specs. Use this
when you want to specify that an error is raised by an action, even if that
error is later captured by a ``rescue_from()`` declaration.

    describe AccountController do
      describe "GET @account" do
        context "requested by anonymous user" do
          it "denies access" do
            bypass_rescue
            lambda do
              get :show, :id => "37"
            end.should raise_error(AccessDenied)
          end
        end
      end
    end
