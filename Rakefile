require File.join(File.dirname(__FILE__), 'lib/dashboard.rb')

unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'
  require 'cucumber/rake/task'
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
  require 'coveralls/rake/task'

  Coveralls::RakeTask.new
  Cucumber::Rake::Task.new
  RSpec::Core::RakeTask.new

  task :default => [:spec, :cucumber, 'coveralls:push']
end
