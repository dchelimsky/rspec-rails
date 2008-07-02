require 'rubygems'
require 'hoe'
require './lib/spec/rails/version'

class Hoe
  def extra_deps
    @extra_deps.reject! { |x| Array(x).first == 'hoe' }
    @extra_deps
  end
end

Hoe.new('rspec-rails', Spec::Rails::VERSION::STRING) do |p|
  p.summary = Spec::Rails::VERSION::SUMMARY
  p.url = 'http://rspec.info/'
  p.description = "Behaviour Driven Development for Ruby on Rails."
  p.rubyforge_name = 'rspec'
  p.developer('RSpec Development Team', 'rspec-devel@rubyforge.org')
end
