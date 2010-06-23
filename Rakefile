require 'rake'

require File.expand_path('../lib/octant/version', __FILE__)

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'octant'
    gem.summary     = 'Octant'
    gem.homepage    = 'http://github.com/antw/octant'
    gem.description = 'A framework-agnostic library for creating web-app navigation.'

    gem.author      = 'Anthony Williams'
    gem.email       = 'hi@antw.me'

    gem.platform    = Gem::Platform::RUBY
    gem.has_rdoc    = false

    # Dependencies.
    gem.add_development_dependency 'rspec-core',         '>= 2.0.0.beta.12'
    gem.add_development_dependency 'rspec-expectations', '>= 2.0.0.beta.12'
    gem.add_development_dependency 'rspec-mocks',        '>= 2.0.0.beta.12'

    gem.add_development_dependency 'cucumber', '>= 0.8'
    gem.add_development_dependency 'nokogiri', '>= 1.4'
    gem.add_development_dependency 'webrat',   '>= 0.7'

    gem.add_development_dependency 'yard',     '>= 0.5'
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

FileList['tasks/**/*.rake'].each { |task| import task }
