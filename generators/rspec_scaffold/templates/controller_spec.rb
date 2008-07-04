require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper')

describe <%= controller_class_name %>Controller do

  def mock_<%= file_name %>(stubs={})
    @mock_<%= file_name %> ||= mock_model(<%= class_name %>, stubs)
  end

  describe "responding to GET /<%= table_name %>" do

    it "should assign all <%= table_name.pluralize %> for the view" do
      <%= class_name %>.should_receive(:find).with(:all).and_return([mock_<%= file_name %>])
      get :index
      assigns[:<%= table_name %>].should == [mock_<%= file_name %>]
    end

  end

  describe "responding to GET /<%= table_name %>.xml" do
  
    it "should render all <%= table_name.pluralize %> as xml" do
      request.env["HTTP_ACCEPT"] = "application/xml"
      <%= class_name %>.should_receive(:find).with(:all).and_return(<%= file_name.pluralize %> = mock("Array of <%= class_name.pluralize %>"))
      <%= file_name.pluralize %>.should_receive(:to_xml).and_return("generated XML")
      get :index
      response.body.should == "generated XML"
    end
    
  end

  describe "responding to GET /<%= table_name %>/1" do

    it "should assign the identified <%= file_name %> for the view" do
      <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
      get :show, :id => "37"
      assigns[:<%= file_name %>].should equal(mock_<%= file_name %>)
    end
    
  end

  describe "responding to GET /<%= table_name %>/1.xml" do

    it "should render the identified <%= file_name %> as xml" do
      request.env["HTTP_ACCEPT"] = "application/xml"
      <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
      mock_<%= file_name %>.should_receive(:to_xml).and_return("generated XML")
      get :show, :id => "37"
      response.body.should == "generated XML"
    end

  end

  describe "responding to GET /<%= table_name %>/new" do
  
    it "should assign a new <%= file_name %> for the view" do
      <%= class_name %>.should_receive(:new).and_return(mock_<%= file_name %>)
      get :new
      assigns[:<%= file_name %>].should equal(mock_<%= file_name %>)
    end

  end

  describe "responding to GET /<%= table_name %>/1/edit" do
  
    it "should assign the requested <%= class_name %> for the view" do
      <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
      get :edit, :id => "37"
      assigns[:<%= file_name %>].should equal(mock_<%= file_name %>)
    end

  end

  describe "responding to POST /<%= table_name %>" do

    describe "with successful save" do

      it "should assign a newly created <%= file_name %> for the view" do
        <%= class_name %>.should_receive(:new).with({'these' => 'params'}).and_return(mock_<%= file_name %>(:save => true))
        post :create, :<%= file_name %> => {:these => 'params'}
        assigns(:<%= file_name %>).should equal(mock_<%= file_name %>)
      end

      it "should redirect to the created <%= file_name %>" do
        <%= class_name %>.stub!(:new).and_return(mock_<%= file_name %>(:save => true))
        post :create, :<%= file_name %> => {}
        response.should redirect_to(<%= table_name.singularize %>_url(mock_<%= file_name %>))
      end
      
    end
    
    describe "with failed save" do

      it "should assign an unsaved <%= file_name %> for the view" do
        <%= class_name %>.stub!(:new).with({'these' => 'params'}).and_return(mock_<%= file_name %>(:save => false))
        post :create, :<%= file_name %> => {:these => 'params'}
        assigns(:<%= file_name %>).should equal(mock_<%= file_name %>)
      end

      it "should re-render the 'new' template" do
        <%= class_name %>.stub!(:new).and_return(mock_<%= file_name %>(:save => false))
        post :create, :<%= file_name %> => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT /<%= table_name %>/1" do

    describe "with successful update" do

      it "should update the requested <%= file_name %>" do
        <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
        mock_<%= file_name %>.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :<%= file_name %> => {:these => 'params'}
      end

      it "should assign the found <%= file_name %> for the view" do
        <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:update_attributes => true))
        put :update, :id => "1"
        assigns(:<%= file_name %>).should equal(mock_<%= file_name %>)
      end

      it "should redirect to the <%= file_name %>" do
        <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(<%= table_name.singularize %>_url(mock_<%= file_name %>))
      end

    end
    
    describe "with failed update" do

      it "should try to update the requested <%= file_name %>" do
        <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
        mock_<%= file_name %>.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :<%= file_name %> => {:these => 'params'}
      end

      it "should assign the <%= file_name %> for the view" do
        <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:update_attributes => false))
        put :update, :id => "1"
        assigns(:<%= file_name %>).should equal(mock_<%= file_name %>)
      end

      it "should re-render the 'edit' template" do
        <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE /<%= table_name %>/1" do

    it "should destroy the requested <%= file_name %>" do
      <%= class_name %>.should_receive(:find).with("37").and_return(mock_<%= file_name %>)
      mock_<%= file_name %>.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the <%= table_name %> list" do
      <%= class_name %>.stub!(:find).and_return(mock_<%= file_name %>(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(<%= table_name %>_url)
    end

  end

end
