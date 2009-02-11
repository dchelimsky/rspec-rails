require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper')

describe <%= controller_class_name %>Controller do

  def mock_<%= file_name %>(stubs={})
    @mock_<%= file_name %> ||= mock_model(<%= class_name %>, stubs)
  end
  
  describe "GET index" do

    it "exposes all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
      <%= class_name %>.should_receive(:find).with(:all).and_return([mock_<%= file_name %>])
      get :index
      assigns[:<%= table_name %>].should == [mock_<%= file_name %>]
    end

    describe "with mime type of xml" do
  
      it "renders all <%= table_name.pluralize %> as xml" do
        <%= class_name %>.should_receive(:find).with(:all).and_return(<%= file_name.pluralize %> = mock("Array of <%= class_name.pluralize %>"))
        <%= file_name.pluralize %>.should_receive(:to_xml).and_return("generated XML")
        get :index, :format => 'xml'
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "GET show" do

    it "exposes the requested <%= file_name %> as @<%= file_name %>" do
      <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
      get :show, :id => "37"
      assigns[:<%= file_name %>].should equal(mock_<%= file_name %>)
    end
    
    describe "with mime type of xml" do

      it "renders the requested <%= file_name %> as xml" do
        <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
        mock_<%= file_name %>.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37", :format => 'xml'
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "GET new" do
  
    it "exposes a new <%= file_name %> as @<%= file_name %>" do
      <%= class_name %>.should_receive(:new).and_return(mock_<%= file_name %>)
      get :new
      assigns[:<%= file_name %>].should equal(mock_<%= file_name %>)
    end

  end

  describe "GET edit" do
  
    it "exposes the requested <%= file_name %> as @<%= file_name %>" do
      <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
      get :edit, :id => "37"
      assigns[:<%= file_name %>].should equal(mock_<%= file_name %>)
    end

  end

  describe "POST create" do

    describe "with valid params" do
      
      it "exposes a newly created <%= file_name %> as @<%= file_name %>" do
        <%= class_name %>.should_receive(:new).with({'these' => 'params'}).and_return(mock_<%= file_name %>(:save => true))
        post :create, :<%= file_name %> => {:these => 'params'}
        assigns(:<%= file_name %>).should equal(mock_<%= file_name %>)
      end

      it "redirects to the created <%= file_name %>" do
        <%= class_name %>.stub!(:new).and_return(mock_<%= file_name %>(:save => true))
        post :create, :<%= file_name %> => {}
        response.should redirect_to(<%= table_name.singularize %>_url(mock_<%= file_name %>))
      end
      
    end
    
    describe "with invalid params" do

      it "exposes a newly created but unsaved <%= file_name %> as @<%= file_name %>" do
        <%= class_name %>.stub!(:new).with({'these' => 'params'}).and_return(mock_<%= file_name %>(:save => false))
        post :create, :<%= file_name %> => {:these => 'params'}
        assigns(:<%= file_name %>).should equal(mock_<%= file_name %>)
      end

      it "re-renders the 'new' template" do
        <%= class_name %>.stub!(:new).and_return(mock_<%= file_name %>(:save => false))
        post :create, :<%= file_name %> => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "PUT udpate" do

    describe "with valid params" do

      it "updates the requested <%= file_name %>" do
        <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
        mock_<%= file_name %>.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :<%= file_name %> => {:these => 'params'}
      end

      it "exposes the requested <%= file_name %> as @<%= file_name %>" do
        <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:update_attributes => true))
        put :update, :id => "1"
        assigns(:<%= file_name %>).should equal(mock_<%= file_name %>)
      end

      it "redirects to the <%= file_name %>" do
        <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(<%= table_name.singularize %>_url(mock_<%= file_name %>))
      end

    end
    
    describe "with invalid params" do

      it "updates the requested <%= file_name %>" do
        <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
        mock_<%= file_name %>.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :<%= file_name %> => {:these => 'params'}
      end

      it "exposes the <%= file_name %> as @<%= file_name %>" do
        <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:update_attributes => false))
        put :update, :id => "1"
        assigns(:<%= file_name %>).should equal(mock_<%= file_name %>)
      end

      it "re-renders the 'edit' template" do
        <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "DELETE destroy" do

    it "destroys the requested <%= file_name %>" do
      <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
      mock_<%= file_name %>.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the <%= table_name %> list" do
      <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(<%= table_name %>_url)
    end

  end

end
