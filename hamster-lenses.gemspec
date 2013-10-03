# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hamster/lenses/version'

Gem::Specification.new do |spec|
  spec.name          = "hamster-lenses"
  spec.version       = Hamster::Lenses::VERSION
  spec.authors       = ["Yura Taras"]
  spec.email         = ["yura.taras@gmail.com"]
  spec.description   = %q{Lenses library for immutable collections inspired
by Haskell and Scala libraries}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/ytaras/hamster-lenses"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "hamster"
  spec.add_dependency "preconditions"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry-byebug"

end
