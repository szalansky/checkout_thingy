# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'checkout_thingy/version'

Gem::Specification.new do |spec|
  spec.name          = "checkout_thingy"
  spec.version       = CheckoutThingy::VERSION
  spec.authors       = ["szalansky"]
  spec.email         = ["raf@szalansky.com"]
  spec.description   = "Little checkout thingy"
  spec.summary       = "See above"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

end
