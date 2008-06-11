module ExplicitHelper
  def method_in_explicit_helper
    "<div>This is text from a method in the ExplicitHelper</div>"
  end
  
  # this is an example of a method spec'able with eval_erb in helper specs
  def prepend(arg, &block)
    concat(arg, block.binding) + block.call
  end
  
  def named_url
    rspec_on_rails_specs_url
  end
  
  def named_path
    rspec_on_rails_specs_path
  end
end
