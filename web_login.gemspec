# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'web_login/version'

Gem::Specification.new do |spec|
  spec.name          = "web_login"
  spec.version       = WebLogin::VERSION
  spec.authors       = ["Daniel Staudigel"]
  spec.email         = ["dstaudigel@gmail.com"]
  spec.description   = %q{Write a gem description}
  spec.summary       = %q{Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "omniauth" , "~> 1.2.1"
  spec.add_runtime_dependency "omniauth-facebook"
end
