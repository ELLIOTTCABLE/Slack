($:.unshift File.expand_path(File.join( File.dirname(__FILE__), 'lib' ))).uniq!
require 'slack'

# ===============
# = Speck tasks =
# ===============
begin
  require 'spark/rake/speck_task'
  
  task :default => :'speck:run'
  task :speck => :'speck:run'
  namespace :speck do
    Spark::Rake::SpeckTask.new :run
  end
  
rescue LoadError
  desc 'You need the `speck` and `spark` gems to run specks'
  task :speck
end

# =======================
# = Documentation tasks =
# =======================
begin
  require 'yard'
  require 'yard/rake/yardoc_task'
  
  task :documentation => :'documentation:generate'
  namespace :documentation do
    YARD::Rake::YardocTask.new :generate do |t|
      t.files   = ['lib/**/*.rb']
      t.options = ['--output-dir', File.join('meta', 'documentation'),
                   '--readme', 'README.markdown',
                   '--markup', 'markdown', '--markup-provider', 'maruku']
    end
    
    task :open do
      system 'open ' + File.join('meta', 'documentation', 'index.html') if RUBY_PLATFORM['darwin']
    end
  end
  
rescue LoadError
  desc 'You need the `yard` and `maruku` gems to generate documentation'
  task :documentation
end


namespace :package do
  task :package do; system "gem build " + Dir['*.gemspec'].first; end
  task :install => :package do; system "gem install " + Dir['*.gem'].first; end
end

desc 'Check everything over before commiting'
task :aok => [:'documentation:generate', :'documentation:open',
              :'package:package',
              :'speck:run']

task :ci => [:'documentation:generate', :'speck:run']
