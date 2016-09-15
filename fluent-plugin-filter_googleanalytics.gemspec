# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-filter_googleanalytics"
  gem.version       = "0.2.0"
  gem.authors       = "Coen Meerbeek"
  gem.email         = "cmeerbeek@gmail.com"
  gem.description   = %q{Filter plugin for Google Analytics messages.}
  gem.homepage      = "https://github.com/cmeerbeek/fluent-plugin-filter_googleanalytics"
  gem.summary       = %q{This plugin makes sure that only recent data (based on time) is sent to output queue..}
  
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "fluentd", [">= 0.10.58", "< 2"]
  gem.add_development_dependency "rake", '~> 0.9', '>= 0.9.2'
  gem.add_development_dependency "test-unit", '~> 3.1', '>= 3.1.0'
  gem.license = 'MIT'
end
