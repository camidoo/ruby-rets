# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rets/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-rets"
  spec.version       = RETS::VERSION
  spec.authors       = ["Placester"]
  spec.email         = ["chris@realscout.com"]
  spec.summary       = %q{Mirror of the github ruby-rets gem}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency 'nokogiri', '>= 1.5.0'
  spec.add_runtime_dependency 'multi_xml', '>= 0.5.2'
end
