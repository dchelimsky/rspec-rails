# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spec/rails/version"

Gem::Specification.new do |s|
  s.name        = "rspec-rails"
  s.version     = Spec::Rails::VERSION::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["RSpec Development Team"]
  s.email       = ["rspec-devel@rubyforge.org"]
  s.homepage    = "http://github.com/dchelimsky/rspec-rails"
  s.summary     = Spec::Rails::VERSION::SUMMARY
  s.description = "Behaviour Driven Development for Ruby on Rails."

  s.rubyforge_project = "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rspec", "~> 1.3.1"
  s.add_dependency "rack", ">= 1.0.0"
  s.add_development_dependency "cucumber",">= 0.3.99"
end
