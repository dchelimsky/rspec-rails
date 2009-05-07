require File.dirname(__FILE__) + '/../rspec_default_values'

class IntegrationSpecGenerator < ModelGenerator
  def manifest
    record do |m|
      m.class_collisions class_path, class_name
      m.template 'integration_spec.rb',  File.join('spec/integration', class_path, "managing_#{table_name}_spec.rb")
    end
  end
end
