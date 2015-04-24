# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'depinjeng/version'

Gem::Specification.new do |spec|
  spec.name          = "depinjeng"
  spec.version       = Depinjeng::VERSION
  spec.authors       = ["ATHN"]
  spec.email         = ["lew_and_david@athn.org"]
  spec.description   = %q{Demonstrate DI in Ruby}
  spec.summary       = %q{Demonstrate DI in Ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
