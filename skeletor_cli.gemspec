# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skeletor_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "skeletor_cli"
  spec.version       = SkeletorCLI::VERSION
  spec.authors       = ["Dean"]
  spec.email         = ["deangalvin3@gmail.com"]

  spec.summary       = "The cli tool for using skeletor app skeletons."
  spec.description   = "The cli tool for using skeletor app skeletons."
  spec.homepage      = "https://www.github.com"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{bin,lib}/**/*")
  spec.bindir        = "bin"
  spec.executables   = "skeletor"
  spec.require_paths = ["lib"]

  spec.add_dependency "skeletor_api"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
