require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper')

describe "Managing <%= class_name.pluralize %>" do
  before(:each) do
    @valid_attributes = {
<% attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= attribute.default_value %><%= attribute_index == attributes.length - 1 ? '' : ','%>
<% end -%>
    }
  end

  describe "viewing index" do
    it "lists all <%= class_name.pluralize %>" do
      <%= class_name.underscore %> = <%= class_name %>.create!(@valid_attributes)
      visit <%= class_name.pluralize.underscore %>_path
      response.should have_selector("a", :href => <%= class_name.underscore %>_path(<%= class_name.underscore %>))
    end
  end
end
