require 'bundler'
Bundler::GemHelper.install_tasks

$:.unshift(File.expand_path(File.join(File.dirname(__FILE__),"..","rspec","lib")))
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__),"lib")))

require 'spec/rails/version'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new

task :default => [:features]
