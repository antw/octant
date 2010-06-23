begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:specs_only) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
  end

  desc "Run the specs, followed by the Cucumber features (if specs pass)"
  task :spec => [:specs_only, :features]

rescue LoadError
  task :spec do
    abort 'rspec is not available. In order to run spec, you must: gem ' \
          'install rspec --pre'
  end
end
