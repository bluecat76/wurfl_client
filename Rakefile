require 'rake/rdoctask'
require 'rake/testtask'
require 'shoulda/tasks'

task :default => ['test']

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/*_test.rb']
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "wurfl_client"
    gemspec.summary = "Fast WURFL mobile device detection"
    gemspec.description = "WURFL Client is a library to do WURFL (http://wurfl.sourceforge.net/) mobile device detection for web applications. Included are tools to keep the WURFL file up to date automatically and to prepare a customized lookup tables, which allow a fast device detection."
    gemspec.email = "guido.pinkas@bindertrittenwein.com"
    gemspec.homepage = "http://github.com/bluecat76/wurfl_client"
    gemspec.authors = ["Guido Pinkas"]
    gemspec.add_dependency 'wurfl', '>=1.3.6'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'WURFL Client'
  rdoc.main     = "README"
  rdoc.rdoc_files.include("README", "lib/**/*.rb")
end
