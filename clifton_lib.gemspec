# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clifton_lib/version'

Gem::Specification.new do |spec|
  spec.name          = "clifton_lib"
  spec.version       = CliftonLib::VERSION
  spec.authors       = ["Marc Clifton"]
  spec.email         = ["marc.clifton@gmail.com"]
  spec.description   = %q{A collection of useful helper classes, initially a set of classes to support creation and serialization of XML.}
  spec.summary       = %q{Collection of useful helper classes.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
