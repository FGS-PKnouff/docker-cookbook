require 'chef/cookbook/metadata'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'

namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any']
    }
  end
end

desc 'Run all style checks'
task style: ['style:ruby', 'style:chef']

desc 'Run ChefSpec'
RSpec::Core::RakeTask.new(:unit) do |tests|
  tests.pattern = './**/unit/**/*_spec.rb'
  tests.rspec_opts = '--format RspecJunitFormatter --out test-results.xml'
end

task default: %w[style unit]
