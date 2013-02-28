# -*- encoding: utf-8 -*-
($:.unshift File.expand_path(File.join( File.dirname(__FILE__), 'lib' ))).uniq!

Gem::Specification.new do |gem|
   gem.name = 'slack'; require gem.name
   gem.version = Slack::VERSION
   gem.homepage = "http://github.com/elliottcable/slack"
   
   gem.author = "elliottcable [http://ell.io/tt]"
   gem.license = 'MIT'
   
   gem.summary = "An extension to Speck, providing convenience methods and monkey-patches."
   
   gem.files = Dir['lib/**/*'] + %w[README.markdown LICENSE.text] & `git ls-files -z`.split("\0")
  
   gem.add_dependency 'speck', ">= 1"
   
   gem.add_development_dependency 'spark'
   gem.add_development_dependency 'yard', ">= 0.8.5.2"
   gem.add_development_dependency 'maruku', ">= 0.6.1"
end

