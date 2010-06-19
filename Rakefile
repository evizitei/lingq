require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "lingq"
    gem.summary = %Q{API Wrapper for Lingq.com}
    gem.description = %Q{Gem for interacting with the API of lingq.com.  It's a language learning website, and it's pretty useful, but I want to be able to work on my flashcards offline.  This gem is being written to be included in a desktop client (and maybe eventually a mobile client), but will certainly still be useful as a standalone api wrapper for other projects that want to interact with Lingq.com}
    gem.email = "ethan.vizitei@gmail.com"
    gem.homepage = "http://github.com/evizitei/lingq"
    gem.authors = ["Ethan Vizitei"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_dependency "httparty", ">= 0"
    gem.add_dependency "bundler", ">= 0"
    gem.add_development_dependency "test-unit", ">= 0"
    gem.add_development_dependency "webmock", ">= 0"
    gem.add_development_dependency "mocha", ">= 0"
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

#dont need this, we're using bundler
#task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "lingq #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
